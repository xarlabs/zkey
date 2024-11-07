from garaga.definitions import G1G2Pair, G1Point, G2Point
from garaga.starknet.groth16_contract_generator.parsing_utils import (
    Groth16Proof,
    Groth16VerifyingKey,
)
from garaga.starknet.tests_and_calldata_generators.mpcheck import MPCheckCalldataBuilder
from garaga.starknet.tests_and_calldata_generators.msm import MSMCalldataBuilder

import uuid

import aiofiles
import asyncio
import grpc
import os
from concurrent import futures
import garaga_pb2
import garaga_pb2_grpc

import ujson
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

VK_PATH = "/root/garaga/garaga/hydra/garaga/starknet/groth16_contract_generator/examples/verify_no_sha256.json"

def groth16_calldata_from_vk_and_proof(
    vk: Groth16VerifyingKey, proof: Groth16Proof
) -> list[int]:
    assert (
        vk.curve_id == proof.curve_id
    ), f"Curve ID mismatch: {vk.curve_id} != {proof.curve_id}"

    vk_x = vk.ic[0].add(G1Point.msm(vk.ic[1:], proof.public_inputs))

    calldata = []

    mpc = MPCheckCalldataBuilder(
        vk.curve_id,
        pairs=[
            G1G2Pair(p=vk_x, q=vk.gamma, curve_id=vk.curve_id),
            G1G2Pair(p=proof.c, q=vk.delta, curve_id=vk.curve_id),
            G1G2Pair(p=-proof.a, q=proof.b, curve_id=vk.curve_id),
        ],
        n_fixed_g2=2,
        public_pair=G1G2Pair(vk.alpha, vk.beta, vk.curve_id),
    )

    calldata.extend(proof.serialize_to_calldata())
    calldata.extend(mpc.serialize_to_calldata())

    if proof.image_id and proof.journal_digest:
        # Risc0 mode.
        msm = MSMCalldataBuilder(
            curve_id=vk.curve_id,
            points=[vk.ic[3], vk.ic[4]],
            scalars=[proof.public_inputs[2], proof.public_inputs[3]],
        )
        calldata.extend(
            msm.serialize_to_calldata(
                include_digits_decomposition=True,
                include_points_and_scalars=False,
                serialize_as_pure_felt252_array=True,
                risc0_mode=True,
            )
        )
    else:
        msm = MSMCalldataBuilder(
            curve_id=vk.curve_id,
            points=vk.ic[1:],
            scalars=proof.public_inputs,
        )

        calldata.extend(
            msm.serialize_to_calldata(
                include_digits_decomposition=True,
                include_points_and_scalars=False,
                serialize_as_pure_felt252_array=True,
                risc0_mode=False,
            )
        )

    # return calldata
    return [len(calldata)] + calldata

async def save_to_json(path, content):
    async with aiofiles.open(path, 'w') as file:
        await file.write(ujson.dumps(content))

async def delete_file(path):
    try:
        os.remove(path)
    except Exception as e:
        logger.error(f"Failed to delete file {path}: {str(e)}")


class Groth16Service(garaga_pb2_grpc.GaragaServiceServicer):
    async def GenerateCalldata(self, request, context):
        logger.info("Processing GenerateCalldata request")
        #logger.info("Received witness JSON:", request.input)
        #logger.info("Received proof JSON:", request.proof)
        input = ujson.loads(request.input)
        proof = ujson.loads(request.proof)
        vk = Groth16VerifyingKey.from_json(file_path=VK_PATH)

        proof_path = f"{uuid.uuid1()}.json"
        await save_to_json(proof_path, proof)
        input_path = f"{uuid.uuid1()}.json"
        await save_to_json(input_path, input)
        proof = Groth16Proof.from_json(
            proof_path=proof_path, public_inputs_path=input_path
        )

        try:
            calldata = groth16_calldata_from_vk_and_proof(vk, proof)
            calldata_str = str(calldata)  # Convert to string if necessary for response
        except Exception as e:
            logger.error(f"Error processing calldata: {str(e)}")
            return garaga_pb2.GaragaResponse(code=-1, calldata=str(e))
        finally:
            await asyncio.gather(delete_file(proof_path), delete_file(input_path))

        logger.info("Successfully processed GenerateCalldata request")
        return garaga_pb2.GaragaResponse(code=0, calldata=calldata_str)

async def serve():
    server = grpc.aio.server()
    garaga_pb2_grpc.add_GaragaServiceServicer_to_server(Groth16Service(), server)
    server.add_insecure_port('[::]:50053')
    print ("running")
    await server.start()
    await server.wait_for_termination()

if __name__ == '__main__':
    asyncio.run(serve())

# if __name__ == "__main__":
#     VK_PATH = "hydra/garaga/starknet/groth16_contract_generator/examples/verify.json"
#     PROOF_PATH = "hydra/garaga/starknet/groth16_contract_generator/examples/proof.json"
#     PUBLIC_INPUTS_PATH = "hydra/garaga/starknet/groth16_contract_generator/examples/public.json"

#     vk = Groth16VerifyingKey.from_json(file_path=VK_PATH)
#     proof = Groth16Proof.from_json(
#         proof_path=PROOF_PATH, public_inputs_path=PUBLIC_INPUTS_PATH
#     )

#     calldata = groth16_calldata_from_vk_and_proof(vk, proof)

#     print(calldata)



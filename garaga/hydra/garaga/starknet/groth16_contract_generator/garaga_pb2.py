# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: garaga.proto
# Protobuf Python Version: 5.26.1
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import symbol_database as _symbol_database
from google.protobuf.internal import builder as _builder
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x0cgaraga.proto\x12\x06garaga\"-\n\rGaragaRequest\x12\r\n\x05proof\x18\x01 \x01(\t\x12\r\n\x05input\x18\x02 \x01(\t\"0\n\x0eGaragaResponse\x12\x0c\n\x04\x63ode\x18\x01 \x01(\x05\x12\x10\n\x08\x63\x61lldata\x18\x02 \x01(\t2R\n\rGaragaService\x12\x41\n\x10GenerateCalldata\x12\x15.garaga.GaragaRequest\x1a\x16.garaga.GaragaResponseb\x06proto3')

_globals = globals()
_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, _globals)
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'garaga_pb2', _globals)
if not _descriptor._USE_C_DESCRIPTORS:
  DESCRIPTOR._loaded_options = None
  _globals['_GARAGAREQUEST']._serialized_start=24
  _globals['_GARAGAREQUEST']._serialized_end=69
  _globals['_GARAGARESPONSE']._serialized_start=71
  _globals['_GARAGARESPONSE']._serialized_end=119
  _globals['_GARAGASERVICE']._serialized_start=121
  _globals['_GARAGASERVICE']._serialized_end=203
# @@protoc_insertion_point(module_scope)

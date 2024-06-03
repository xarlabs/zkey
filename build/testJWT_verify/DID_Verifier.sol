// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

contract Groth16Verifier {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 20491192805390485299153009773594534940189261866228447918068658471970481763042;
    uint256 constant alphay  = 9383485363053290200918347156157836566562967994039712273449902621266178545958;
    uint256 constant betax1  = 4252822878758300859123897981450591353533073413197771768651442665752259397132;
    uint256 constant betax2  = 6375614351688725206403948262868962793625744043794305715222011528459656738731;
    uint256 constant betay1  = 21847035105528745403288232691147584728191162732299865338377159692350059136679;
    uint256 constant betay2  = 10505242626370262277552901082094356697409835680220590971873171140371331206856;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant deltax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant deltay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant deltay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;

    
    uint256 constant IC0x = 3425459549323782355166891319959601626816289537932247010744727017087071746007;
    uint256 constant IC0y = 4162307059459534975020951566036350640051040795171266465332972474231707514663;
    
    uint256 constant IC1x = 14072081078137657048017492297137211829228087033644322633451649013327248614819;
    uint256 constant IC1y = 17899919511109195609057607215988137483237750179218358510289662063772785447399;
    
    uint256 constant IC2x = 21658447299319542048103867441651063238335126034756904229656279319334465148564;
    uint256 constant IC2y = 8932184790219733953037876639948680056113479430331325773959455837700164051762;
    
    uint256 constant IC3x = 3473394513318540431480932047777690824339747140802045254908745989732623926150;
    uint256 constant IC3y = 13540855292007274049845173700207626290467034153085666391742974473150396855043;
    
    uint256 constant IC4x = 11941718729109244110456815820552932924541373522567061599503762837131192354243;
    uint256 constant IC4y = 21559256568782034959286550134006671593860183745008865286662591330523936747574;
    
    uint256 constant IC5x = 21185757747472532635755519307412551446612301934355717233720580875428947040819;
    uint256 constant IC5y = 2826147110018320670479063462504942848225554517194220306807402493401965164542;
    
    uint256 constant IC6x = 14249562570488791219658589021600623613551834384301278780597657942135483449115;
    uint256 constant IC6y = 2165924401364464168316304586949940651436269148042531451975228183861656104750;
    
    uint256 constant IC7x = 458646063393917409825081074578833512442784577833144537316031153902389314731;
    uint256 constant IC7y = 20303446638432960277487815806006709216939173392611203713586125527071026762700;
    
    uint256 constant IC8x = 20753459522159130576791527699433987341241992443190549945776794303712337639415;
    uint256 constant IC8y = 13452350253914961833391046011707172405596383947223038319384463685120145036631;
    
    uint256 constant IC9x = 15775823335881076628463886347249367168840708367797813358842136414413371744623;
    uint256 constant IC9y = 2886908010447663548881089477561823721503178231740300420830307488993966287415;
    
    uint256 constant IC10x = 3856843007659565422021715046793374211095228047019042665746822742714966232882;
    uint256 constant IC10y = 14276716814826614686004783197835971623673019814045601926456160484163063878824;
    
    uint256 constant IC11x = 755510986740753030051768136198233844739169474133921684855995762140790871805;
    uint256 constant IC11y = 20193065001100078066282667703634390093046768364202382785746990319937491600684;
    
    uint256 constant IC12x = 10433645253599845135253224192046292288531740405241031729119018833317643881490;
    uint256 constant IC12y = 5193850373422374248577852131861523549825821523795965481490576200999071188141;
    
    uint256 constant IC13x = 2206109030849467177942359660836195231622074788649015574132241189868814614362;
    uint256 constant IC13y = 16946986414873184043446217707575081788382951294914337874936399314600121560733;
    
    uint256 constant IC14x = 13231673253181059516775054629535645296486244053887121006863123380427123168011;
    uint256 constant IC14y = 4469016888421896295365462930557018204088614599519029389758416742071859438066;
    
    uint256 constant IC15x = 20247669002800600489802480966516134648299768677363674310833522109988213695724;
    uint256 constant IC15y = 14693729403166886492140946814690495535272101383489703114852860420895824974247;
    
    uint256 constant IC16x = 2429134744737315135919860312495504179862897829378954158566491241171172369496;
    uint256 constant IC16y = 9179410914042356939304453713182500053264342448644637894750942377447114858284;
    
    uint256 constant IC17x = 13072581085256370515684480434700943874223497982582036214479965397590247662431;
    uint256 constant IC17y = 4936354598611258213395698953068234653351855008193098861943222566790900855574;
    
    uint256 constant IC18x = 15691476124665683146085335151880876599014081811360390281096487708027811653821;
    uint256 constant IC18y = 3258196216788578285379700252566297584024415421959087925776275242143169584955;
    
    uint256 constant IC19x = 14846542888720880109849038443218375942574826075263685156110068941345610020399;
    uint256 constant IC19y = 6046757260169674566764816134550654337471333866981623378775957869461864564471;
    
    uint256 constant IC20x = 11952401496895673021670922036282412390017136902871339449293495920065089002141;
    uint256 constant IC20y = 13520183760117286355718864645216281408142929500050917535198887796474843507023;
    
    uint256 constant IC21x = 16404586394369615265636698239943667692362914298535972288308219827952429498452;
    uint256 constant IC21y = 2583598768194289312055167056814156912221001526611494202582170049737679972576;
    
    uint256 constant IC22x = 551720736143178404314292109792051851461273369449423179402752588365946872493;
    uint256 constant IC22y = 10196267143836108088887176817564259763722844572516178574022516564511167403768;
    
    uint256 constant IC23x = 21116672257796521496589216691109983716107439641104428304535092070829954963467;
    uint256 constant IC23y = 7249972221210283172432484572300813648810066876432056381620573994624967916462;
    
    uint256 constant IC24x = 15761787555116587768045177211537141479861829630350067018720944386624566879301;
    uint256 constant IC24y = 21319839568238907873419102328054530847592266613704354360909858506631943873647;
    
    uint256 constant IC25x = 12030306157849288490038112945654281102024402208016340225513925902452022236982;
    uint256 constant IC25y = 17617599271198123337149106325454996908685473536622008909581554749975617392581;
    
    uint256 constant IC26x = 1290526403112596695672114580740023996591569220278357911165594086839579345736;
    uint256 constant IC26y = 20740448918659623205756662049948258115453529957962090009353572942655590427553;
    
    uint256 constant IC27x = 16447974344490583966092702418034033902656011670084940618952344142761096893425;
    uint256 constant IC27y = 15400638321683542310749265392754699387003236268209221801592819723316252607706;
    
    uint256 constant IC28x = 13852894872496273429379060752538234467641735232883359812346441415425124798686;
    uint256 constant IC28y = 21373486383444295765850524154538161370936295639120268370948747307196615113775;
    
    uint256 constant IC29x = 14777929335362078099750262042840482305775530217632388785535674176591948156668;
    uint256 constant IC29y = 4736926134029963660264099797597789531191139085885171577181352511976071968167;
    
    uint256 constant IC30x = 6693912286222544557276561280263334720173843914109167157434372340463568176505;
    uint256 constant IC30y = 4680474971459033846958377518304998206095071387160024284554090655169193682469;
    
    uint256 constant IC31x = 2356158218960895108336763633586360621895776822771044138573463875864847909651;
    uint256 constant IC31y = 16674449359996317936696249348874373332466165615892006731733784786620973166699;
    
    uint256 constant IC32x = 18757863467097128696279437485603414954683361925963690877792791235358306014081;
    uint256 constant IC32y = 615137567031786008514639289832891467604056738087312187808242150031418593540;
    
    uint256 constant IC33x = 9443633705388683752936636226238397987253514807525218422733047656921834193002;
    uint256 constant IC33y = 10806583850852992858810997531091331986936081926955003972160421072827030077538;
    
    uint256 constant IC34x = 3164111186226349091582467188767660261042388224673664836618597672432640747904;
    uint256 constant IC34y = 7816616343802826536306924470423081771180880725889355302429095280655006299862;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[34] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }
            
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x
                
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                
                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))
                
                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))
                
                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))
                
                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))
                
                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))
                
                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))
                
                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))
                
                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))
                
                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))
                
                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))
                
                g1_mulAccC(_pVk, IC24x, IC24y, calldataload(add(pubSignals, 736)))
                
                g1_mulAccC(_pVk, IC25x, IC25y, calldataload(add(pubSignals, 768)))
                
                g1_mulAccC(_pVk, IC26x, IC26y, calldataload(add(pubSignals, 800)))
                
                g1_mulAccC(_pVk, IC27x, IC27y, calldataload(add(pubSignals, 832)))
                
                g1_mulAccC(_pVk, IC28x, IC28y, calldataload(add(pubSignals, 864)))
                
                g1_mulAccC(_pVk, IC29x, IC29y, calldataload(add(pubSignals, 896)))
                
                g1_mulAccC(_pVk, IC30x, IC30y, calldataload(add(pubSignals, 928)))
                
                g1_mulAccC(_pVk, IC31x, IC31y, calldataload(add(pubSignals, 960)))
                
                g1_mulAccC(_pVk, IC32x, IC32y, calldataload(add(pubSignals, 992)))
                
                g1_mulAccC(_pVk, IC33x, IC33y, calldataload(add(pubSignals, 1024)))
                
                g1_mulAccC(_pVk, IC34x, IC34y, calldataload(add(pubSignals, 1056)))
                

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))


                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)


                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F
            
            checkField(calldataload(add(_pubSignals, 0)))
            
            checkField(calldataload(add(_pubSignals, 32)))
            
            checkField(calldataload(add(_pubSignals, 64)))
            
            checkField(calldataload(add(_pubSignals, 96)))
            
            checkField(calldataload(add(_pubSignals, 128)))
            
            checkField(calldataload(add(_pubSignals, 160)))
            
            checkField(calldataload(add(_pubSignals, 192)))
            
            checkField(calldataload(add(_pubSignals, 224)))
            
            checkField(calldataload(add(_pubSignals, 256)))
            
            checkField(calldataload(add(_pubSignals, 288)))
            
            checkField(calldataload(add(_pubSignals, 320)))
            
            checkField(calldataload(add(_pubSignals, 352)))
            
            checkField(calldataload(add(_pubSignals, 384)))
            
            checkField(calldataload(add(_pubSignals, 416)))
            
            checkField(calldataload(add(_pubSignals, 448)))
            
            checkField(calldataload(add(_pubSignals, 480)))
            
            checkField(calldataload(add(_pubSignals, 512)))
            
            checkField(calldataload(add(_pubSignals, 544)))
            
            checkField(calldataload(add(_pubSignals, 576)))
            
            checkField(calldataload(add(_pubSignals, 608)))
            
            checkField(calldataload(add(_pubSignals, 640)))
            
            checkField(calldataload(add(_pubSignals, 672)))
            
            checkField(calldataload(add(_pubSignals, 704)))
            
            checkField(calldataload(add(_pubSignals, 736)))
            
            checkField(calldataload(add(_pubSignals, 768)))
            
            checkField(calldataload(add(_pubSignals, 800)))
            
            checkField(calldataload(add(_pubSignals, 832)))
            
            checkField(calldataload(add(_pubSignals, 864)))
            
            checkField(calldataload(add(_pubSignals, 896)))
            
            checkField(calldataload(add(_pubSignals, 928)))
            
            checkField(calldataload(add(_pubSignals, 960)))
            
            checkField(calldataload(add(_pubSignals, 992)))
            
            checkField(calldataload(add(_pubSignals, 1024)))
            
            checkField(calldataload(add(_pubSignals, 1056)))
            
            checkField(calldataload(add(_pubSignals, 1088)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }

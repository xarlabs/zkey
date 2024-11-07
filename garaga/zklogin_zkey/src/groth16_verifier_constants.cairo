use garaga::definitions::{G1Point, G2Point, E12D, G2Line, u384};
use garaga::definitions::u288;
use garaga::groth16::Groth16VerifyingKey;

pub const N_PUBLIC_INPUTS: usize = 7;

pub const vk: Groth16VerifyingKey =
    Groth16VerifyingKey {
        alpha_beta_miller_loop_result: E12D {
            w0: u288 {
                limb0: 0x33f12fd291cd7cf10516e72b,
                limb1: 0x7bbd0c0e44c27751e6afde6b,
                limb2: 0x26403b7896713975
            },
            w1: u288 {
                limb0: 0x85fc6c14cd65c9a970d28efc,
                limb1: 0x5f339b1af6476891a11e3236,
                limb2: 0x14631ca360ad5b0e
            },
            w2: u288 {
                limb0: 0x749b1e2ac349b4661a620a0a,
                limb1: 0x8f2516f41e2753040b532dc,
                limb2: 0x298023b4ade5994a
            },
            w3: u288 {
                limb0: 0x8704612871f430d02d74f912,
                limb1: 0x510669bb441f3478c2ddd5f,
                limb2: 0x6ade3f853f2e182
            },
            w4: u288 {
                limb0: 0xce4d6be72db2316026414ed5,
                limb1: 0xf6dd4ccbc455f22061419481,
                limb2: 0x1ad28403c5bf98eb
            },
            w5: u288 {
                limb0: 0x1d0a304b963c4bd3f0f9a73e,
                limb1: 0x4d06d55d75711860545ace9a,
                limb2: 0x18855c74a1233cda
            },
            w6: u288 {
                limb0: 0x6b3b99341551175af1680ec9,
                limb1: 0xa5f5724fed17d8ec6170a6c9,
                limb2: 0x2d384c1ff801743b
            },
            w7: u288 {
                limb0: 0x3b39b7572fd350082d3915ad,
                limb1: 0x26e3a71c6fd54e316b53eab4,
                limb2: 0x254f34193d0ffc2e
            },
            w8: u288 {
                limb0: 0x9404f378321229a4beb3ce,
                limb1: 0x8beeb683c61457d10b596b22,
                limb2: 0x6a6f6d53f698ba1
            },
            w9: u288 {
                limb0: 0x8d9a7deea6ae7d99e6a2358,
                limb1: 0x81fb0aef9e517608eee3da91,
                limb2: 0x12f1dc26aac0e867
            },
            w10: u288 {
                limb0: 0x8a584638e409b576514b8ad,
                limb1: 0x5eb805242db6b9216c6e0064,
                limb2: 0x1324a239944b45d3
            },
            w11: u288 {
                limb0: 0x16f0668ae0216bd1a7ab2cef,
                limb1: 0x6db5ed9cccff368e1d27c30a,
                limb2: 0x2c66c12a91c32a8c
            }
        },
        gamma_g2: G2Point {
            x0: u384 {
                limb0: 0x3e124b2f32dd2d2cadbb5d2d,
                limb1: 0x55cfa59f2f44efbab2b28bdf,
                limb2: 0x1e43ce6d6749bdb3,
                limb3: 0x0
            },
            x1: u384 {
                limb0: 0x7e13777c26a747e24efb6c5e,
                limb1: 0xdd3edd450d3dbf090e176f90,
                limb2: 0x1164f55369843bcc,
                limb3: 0x0
            },
            y0: u384 {
                limb0: 0x290d632ae0be32143195b3eb,
                limb1: 0x7da712c201dcbec4877d5db5,
                limb2: 0x2d611c28fcbcc792,
                limb3: 0x0
            },
            y1: u384 {
                limb0: 0x586b0b86f89d7ee7b993c59e,
                limb1: 0x62af383e56139955f6a285d0,
                limb2: 0x24b10fd84ec608cc,
                limb3: 0x0
            }
        },
        delta_g2: G2Point {
            x0: u384 {
                limb0: 0x35b868b559e08a93a48f0237,
                limb1: 0x359758a6aadbc03c06c08466,
                limb2: 0x21f00878d59033c4,
                limb3: 0x0
            },
            x1: u384 {
                limb0: 0x32c3555b5979c5a6fd4afb9a,
                limb1: 0x1fff14450c7ee43e81bdc974,
                limb2: 0x18f8edcbc3991606,
                limb3: 0x0
            },
            y0: u384 {
                limb0: 0xbaae879cdaab228c5cdfb748,
                limb1: 0x65e159de35298c63517c62b3,
                limb2: 0x130fc0d59225a78,
                limb3: 0x0
            },
            y1: u384 {
                limb0: 0x14d2857fa686fb57f933ac49,
                limb1: 0xf7b2758ed132c3867d1e0531,
                limb2: 0x2d33c0d92ad185ac,
                limb3: 0x0
            }
        }
    };

pub const ic: [
    G1Point
    ; 8] = [
    G1Point {
        x: u384 {
            limb0: 0x7502ceaf1fd3b2c4b56fd832,
            limb1: 0x61f69895c7ed9babbc71d343,
            limb2: 0xcc1ffe36ffb8c34,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x7cf16a4be0fee4bd9820c8f5,
            limb1: 0xf6ec9793272dd2d930bdc1f9,
            limb2: 0xc5a9b5f9489b6df,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0x3886569ddb6bb2624c2897ef,
            limb1: 0xbd42d23b9171eb0f9b444912,
            limb2: 0x8e9ff21e285f5e2,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x332bc953c6e838a62ee6696d,
            limb1: 0x6df6483c66a76797a05005a5,
            limb2: 0x51645fb25b3d78c,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0xc210949cee7828d243f40e17,
            limb1: 0x91400b82dfa3269827dbe437,
            limb2: 0x1598e792f81a46c1,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0xcd952788fa19f452f4308894,
            limb1: 0xab18b8fec60fba068df81dd1,
            limb2: 0x2887c446d4569211,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0x139b476158a42e29aacc915a,
            limb1: 0xcbfa53186fbc1b5ba2827294,
            limb2: 0x2c68098c003c515c,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x9db524cafd1dcd04e004f937,
            limb1: 0x15efce1007ed21e14536cd5c,
            limb2: 0x2047d18e141593b1,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0xe3282631a27641eb6453c3f2,
            limb1: 0x823ef2b2cc22ee2c921d3ab1,
            limb2: 0x19ea62e038b85280,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x799f4262a0512d41877f6d87,
            limb1: 0xfec32a892294712b27aae96e,
            limb2: 0x2536ab9c19814f3e,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0xece38dfa1b76988e6727ee0a,
            limb1: 0xbb154ee569817f1ce4c83e22,
            limb2: 0x17407395ff1fa93c,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x82e4917630b788b73c2663cc,
            limb1: 0x1bc4e8938f5dce3829abad86,
            limb2: 0x17dfb07ccf87bb28,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0x34d926fe6ca184f2b7f9200c,
            limb1: 0xdce64402f56135dbc8a212db,
            limb2: 0x218d08f62c9dacad,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x23517fce4b2c5e7c2e10efc4,
            limb1: 0x50dadecd51b67a54e051685,
            limb2: 0x1ac624a644cc2451,
            limb3: 0x0
        }
    },
    G1Point {
        x: u384 {
            limb0: 0x38a171741044a3d62a44d9f4,
            limb1: 0x907849c8fa151d707d416c9d,
            limb2: 0xd74409935fe26ba,
            limb3: 0x0
        },
        y: u384 {
            limb0: 0x5607c02cded69496ed6b67c5,
            limb1: 0x4b0d1680c05f4b323c0d81ed,
            limb2: 0x20f5ef9ceb66442f,
            limb3: 0x0
        }
    },
];


pub const precomputed_lines: [
    G2Line
    ; 176] = [
    G2Line {
        r0a0: u288 {
            limb0: 0x72f9f4017f40c504d9bb7e44,
            limb1: 0x185766a8ebcb4e4d32584fc0,
            limb2: 0x12ed807cd0865e69
        },
        r0a1: u288 {
            limb0: 0x558236906c33ea7b8f301997,
            limb1: 0x63a276033e0876cf5de02b79,
            limb2: 0xef1a6f97aed0cca
        },
        r1a0: u288 {
            limb0: 0xb44349d4c277fe29e3b92e9a,
            limb1: 0x6792aff6716c00faf1d0743b,
            limb2: 0x29d3fadc4a80f3f4
        },
        r1a1: u288 {
            limb0: 0x31eb512da7445ceb8a009394,
            limb1: 0x67c408d0fba30916bfb6fd95,
            limb2: 0x215906e7c352346a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x97d17037e64b0be63ea76340,
            limb1: 0xed5e48425c8b0430e5f657bd,
            limb2: 0xbd9e97b5a9a8488
        },
        r0a1: u288 {
            limb0: 0xdb76907da711f915fb16ef29,
            limb1: 0x32cead71468a459396a44fff,
            limb2: 0x9bee8dd42a88e78
        },
        r1a0: u288 {
            limb0: 0x7e242ab01772fd430b8f5219,
            limb1: 0xe073f99a9a8f875c1c6f588b,
            limb2: 0x187f6af7e9c2c00f
        },
        r1a1: u288 {
            limb0: 0xfb2f36bb88da06d7abe3c06e,
            limb1: 0xef17f8af536dab23abc7c98c,
            limb2: 0xd426c18653dfd9d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf577d68bbcdfc711fec17f03,
            limb1: 0x9ff8df0d95b60a1065291ad0,
            limb2: 0x1d76cdf610ab41c0
        },
        r0a1: u288 {
            limb0: 0x12ef93fccfeca19b494ce3b0,
            limb1: 0x54adcfb34378e18e39a13f18,
            limb2: 0x2172a7796644935f
        },
        r1a0: u288 {
            limb0: 0xb42e80b879a88decf4c3cead,
            limb1: 0x50bd95c010155762a5b0f655,
            limb2: 0x690539696b0ac35
        },
        r1a1: u288 {
            limb0: 0x3686795f94dc2f2b4e7c69b3,
            limb1: 0x508c3ce585de4f46d7ca6cfc,
            limb2: 0xf0b478b1ddf6bbf
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdce38d2e04d84c7d04dfeada,
            limb1: 0xf68fa25ad9821066a87f1b90,
            limb2: 0x641f59779d0416b
        },
        r0a1: u288 {
            limb0: 0xe8e13626889d75baea321579,
            limb1: 0xb7cb2b2b5392641ea1b4231a,
            limb2: 0x1a379eb7eea4d049
        },
        r1a0: u288 {
            limb0: 0x2865656081013ed198683bf9,
            limb1: 0xe5b2343eca81d6ca47483051,
            limb2: 0x5d7d4036446b6ed
        },
        r1a1: u288 {
            limb0: 0x11227ef7116e49b25cc7768e,
            limb1: 0x7fd8a053d4d5edebd0369ca5,
            limb2: 0xb48ef27895f8177
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd0a05a5555d5803099d59a07,
            limb1: 0xcaf1fd7424f6542cb18b12d3,
            limb2: 0x248a64f786971ba0
        },
        r0a1: u288 {
            limb0: 0x8cfb3a0f950e9300dd660e1e,
            limb1: 0x858198453af712ca00dd1a91,
            limb2: 0x26a565959e8911b1
        },
        r1a0: u288 {
            limb0: 0xea4d9fdd24ad8ed3ccedab2e,
            limb1: 0xd7dc4c1be6f1d1017b121205,
            limb2: 0x17e4e37af76ee019
        },
        r1a1: u288 {
            limb0: 0x6d4293d1b346853f2c993cd9,
            limb1: 0xc9384d072e13ad39ebb9a104,
            limb2: 0x2321e25a7bf3a28b
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x57e6d195b60829a6c2eab003,
            limb1: 0x4e0e0c7636ac1cd97721285b,
            limb2: 0x2cc66d53d87966d3
        },
        r0a1: u288 {
            limb0: 0xa109912810a216077f5b9052,
            limb1: 0xd33fd486d8be80cb1c77e192,
            limb2: 0x5686969abdce2aa
        },
        r1a0: u288 {
            limb0: 0x2abbd68f3345454bf4f214e2,
            limb1: 0x50500177e4815b4879be5b29,
            limb2: 0x17301579a4a92587
        },
        r1a1: u288 {
            limb0: 0x82b654ed08b21932598c0d4b,
            limb1: 0xda01969d000376786b05661f,
            limb2: 0x1fe07af3ed1dc992
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x53183ba289250e2e06de4520,
            limb1: 0x15c4260443683f8292959466,
            limb2: 0x9c2743c1216f66f
        },
        r0a1: u288 {
            limb0: 0x56ee7565ac3d59575dc9ed2c,
            limb1: 0x818136e1181e08a4633687b6,
            limb2: 0x1b3d152ab79a2b14
        },
        r1a0: u288 {
            limb0: 0xe9f427febe50d9dc02c5546b,
            limb1: 0x2a26699bcd64adcff692147e,
            limb2: 0x295960f968fa2a3d
        },
        r1a1: u288 {
            limb0: 0x213c2fbf939f1a8b4bfbb77b,
            limb1: 0x3f34f25058782727a04e1e52,
            limb2: 0x17cb040670123d12
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcd96bc894a1ba7ef81e83ac2,
            limb1: 0x97adf2b1af56b6bb5393ae9b,
            limb2: 0xe6e23bd71308b83
        },
        r0a1: u288 {
            limb0: 0x150f6209902cc3aafa0d3198,
            limb1: 0x105aee92b97a97f860c142f6,
            limb2: 0x17d0adbc1199644c
        },
        r1a0: u288 {
            limb0: 0x779ab681a53d5907180d6bd8,
            limb1: 0xeaec35ca8635a2c397c21f30,
            limb2: 0x17e140818f3cc325
        },
        r1a1: u288 {
            limb0: 0xa1b1dc29bc0ee57f2edf064d,
            limb1: 0x7f8766939f198452817d9afd,
            limb2: 0x17ac3e451f96a7e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xea35e3b882e99c660b0840a0,
            limb1: 0x9b320e43c702dbf312b0535d,
            limb2: 0x17a3f7a43658498f
        },
        r0a1: u288 {
            limb0: 0xd323bcfb5a45a9f10c652472,
            limb1: 0x69b9db57fd9e001cce91992f,
            limb2: 0x346f73e25ca71bd
        },
        r1a0: u288 {
            limb0: 0x3eaac240bbc7b0caf6778b7d,
            limb1: 0x2ebd8278623e2877a294a85e,
            limb2: 0x21a0fb5396ad73a1
        },
        r1a1: u288 {
            limb0: 0x69832b8b9f30a58c381cfba0,
            limb1: 0x1436302681ab7ebf729f841f,
            limb2: 0x2cedbea2b4011fd6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcc2198bc4390be2eefa9fbe5,
            limb1: 0x56fb635a72d02af4acfa9ff2,
            limb2: 0x25904f53a9a68ffc
        },
        r0a1: u288 {
            limb0: 0x265cf8ee430c4605fc1f4cb7,
            limb1: 0xf5af89ad523215e797c7b542,
            limb2: 0x271b51b276a9eb7c
        },
        r1a0: u288 {
            limb0: 0x709cfa8be94fde5cea317d43,
            limb1: 0x2c48b205b6af284f3d52ca41,
            limb2: 0x15bcf1ae2b6588c5
        },
        r1a1: u288 {
            limb0: 0xb82bf0c185d4cc03ee62601e,
            limb1: 0xc1b52bac5fd46842efc774ea,
            limb2: 0x13b68524fcf965b7
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3d7e8e4b5009f712d0862303,
            limb1: 0xddd36c0a6c3ce5de18fd5053,
            limb2: 0x2ee7c6a4aaea6328
        },
        r0a1: u288 {
            limb0: 0x9ebe6a539ada20bf31b8be93,
            limb1: 0xcfe0181b7ed587c31928c6df,
            limb2: 0xe4a14e13cb797a9
        },
        r1a0: u288 {
            limb0: 0xa263bdbec349fe76761c2805,
            limb1: 0xd348f306f63078495a636468,
            limb2: 0xbd6042016598c1a
        },
        r1a1: u288 {
            limb0: 0x51f028bcd85ffaf1468da330,
            limb1: 0x2ad0d55552a79d49b393ecf0,
            limb2: 0x226872176579e0fb
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xec8fd66103ed1399448fe582,
            limb1: 0x4d16bfb6cc91f558ea1f088e,
            limb2: 0xe524065107a4253
        },
        r0a1: u288 {
            limb0: 0x9fafbbf13368640ec63d3caa,
            limb1: 0x2e1ba6710cb57b0f8050d33d,
            limb2: 0x292297e90839600e
        },
        r1a0: u288 {
            limb0: 0xb8c5c4a6b0eee4335f57b6a3,
            limb1: 0xb9a76566871c7abfa4f9fa22,
            limb2: 0x11642bca0f343f7c
        },
        r1a1: u288 {
            limb0: 0x6c06cbc6e296bfe6b9ed139f,
            limb1: 0x2cac86c44423ae8b93c2c396,
            limb2: 0x2a68fd0afb7e6fa9
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf195ec9ab367dfa2c55f6d1c,
            limb1: 0xb22bc29f718a41eb595e4454,
            limb2: 0x5fbb82dfb5d9d51
        },
        r0a1: u288 {
            limb0: 0x463cf90f0ec8ee851e41e606,
            limb1: 0xda7dfa152d4d4a6bc9dd671e,
            limb2: 0x130949d7925c1829
        },
        r1a0: u288 {
            limb0: 0x8c144f5ded207f74bb2440c,
            limb1: 0xec72d1d2367811f8b486287d,
            limb2: 0xf1a43e695aced42
        },
        r1a1: u288 {
            limb0: 0x8eb89cc99a69b261640cee02,
            limb1: 0x8bea9a628a97b7e26f07400e,
            limb2: 0x244e049a2cfc1473
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7f524ffdd982c298511b3906,
            limb1: 0xfa37f9df8510d1baabfd267,
            limb2: 0x2eae1ed15f6c9859
        },
        r0a1: u288 {
            limb0: 0xcb7e3d545e6814210b854bc9,
            limb1: 0x8b3214a7f2ba185aa01f5195,
            limb2: 0x13a4f690e4a02a48
        },
        r1a0: u288 {
            limb0: 0x8eb3b3ef3bf858926779466b,
            limb1: 0x18973d880e37f1ea6f77ccb6,
            limb2: 0x2d21eca31cfeb4a5
        },
        r1a1: u288 {
            limb0: 0xd7520d15c8d806ae65f6f7d,
            limb1: 0xba448acd665a572a5a621e11,
            limb2: 0x11e7e13cfc85a6c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x19aeed76ad274f57e59918a9,
            limb1: 0xabda75b2a2a5366cd05b0d6c,
            limb2: 0xb9c4a4829110932
        },
        r0a1: u288 {
            limb0: 0x9b853c0bedac479be12fb7ac,
            limb1: 0xfa7b9e36ab9e1bf8ef7dd31a,
            limb2: 0x18a3eb2457eb563e
        },
        r1a0: u288 {
            limb0: 0x38583a98507ca985d25b0a7,
            limb1: 0xd3112c02bfa9fb50a4dca036,
            limb2: 0x304a3cb0aaa33b2c
        },
        r1a1: u288 {
            limb0: 0xe7e717b98ce2f772fc07b66f,
            limb1: 0xf09f1447f40804118562b29,
            limb2: 0x2946e5d2b8322b43
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2190822d3e03d6d14c38491a,
            limb1: 0x9bf0623694483a8ddfd01292,
            limb2: 0x505277aad528058
        },
        r0a1: u288 {
            limb0: 0x4dc22298a86d7e161c802ef5,
            limb1: 0xcc84b49e18cd3656288244c7,
            limb2: 0x84ef84f0a7487b3
        },
        r1a0: u288 {
            limb0: 0x2692581d45ef257e352c707b,
            limb1: 0x318fecddf03dd39561b88d4b,
            limb2: 0x31956866960300f
        },
        r1a1: u288 {
            limb0: 0x440c937c3817c0fcc82051c8,
            limb1: 0xe4a49e5d37e7d62dee4e8ffe,
            limb2: 0x52993e0120dcc7e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd284d38fa66b89d9f73ecbf9,
            limb1: 0x300b22a535d05cbf32533664,
            limb2: 0x16120777989fcce
        },
        r0a1: u288 {
            limb0: 0xcc2ca243dbc129684c51432f,
            limb1: 0x937bbab73d3ed4e408efa008,
            limb2: 0x1acd2ecdcc146518
        },
        r1a0: u288 {
            limb0: 0x8db7c0f29ce0cf477964943,
            limb1: 0x5e107336bc44dae11e9d2cab,
            limb2: 0x2e5024f07810caa1
        },
        r1a1: u288 {
            limb0: 0xa7f80ae1e7e8370185f2ecae,
            limb1: 0x1ca1f9d3c3520cc16c9f50b4,
            limb2: 0x1535479afc956cd1
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcb7143aa8ed7303e36e4be20,
            limb1: 0xde48da62f6fbe8a59b53c883,
            limb2: 0x1360bd4278c0e415
        },
        r0a1: u288 {
            limb0: 0x4f2f974498dc51536a083bc5,
            limb1: 0xa5232dcf0810f6528358d8da,
            limb2: 0x220f7be61a7e15a3
        },
        r1a0: u288 {
            limb0: 0x55c3e09def32166df1fcecbf,
            limb1: 0x3dc807de99120ae4237fc69a,
            limb2: 0x275bda3008427266
        },
        r1a1: u288 {
            limb0: 0x85ea326c60610c6d80ead9bd,
            limb1: 0x780d6e4366cd011a3cb702fc,
            limb2: 0xcd44e496cc9ea63
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfedc2491ee3233b9be628167,
            limb1: 0x40e0a4b84c0492d5ad7197e5,
            limb2: 0x1bc538b9ad3773a0
        },
        r0a1: u288 {
            limb0: 0xe2da5796e02a8615b42bce20,
            limb1: 0xab281de45c80e4a6ba99e9cd,
            limb2: 0x2d3750f46424ce3b
        },
        r1a0: u288 {
            limb0: 0xf12b302466b9f68960bc11b6,
            limb1: 0xf22c84a468eaa098a2eb34e1,
            limb2: 0xd6b41d3990ff6b6
        },
        r1a1: u288 {
            limb0: 0xc9be622176f0cfd97344b1c1,
            limb1: 0xbcd23d5c73c86350d193ec22,
            limb2: 0xbcc55b729410ba5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdd16a19deb156c48a995898b,
            limb1: 0x5edd35c41e58cd4d3d02b2dd,
            limb2: 0xcb8bcaeb5b4d64f
        },
        r0a1: u288 {
            limb0: 0x4fa8cbea547da67c30c14c57,
            limb1: 0xfe55b8e2f0de45500e5af429,
            limb2: 0xe90840b26c8d59
        },
        r1a0: u288 {
            limb0: 0x31e6274c4a9e83dad84a1980,
            limb1: 0xa98bd743a13d82ed3d0f2f29,
            limb2: 0x16f6b3ee6b025734
        },
        r1a1: u288 {
            limb0: 0xc88c882a3e4ead6ee8707308,
            limb1: 0x8e0147bb2aa0903d16ace75e,
            limb2: 0x20019a18922d377f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x64e1bea73e33dc89d8010504,
            limb1: 0xc89067f3e6765e6aa6ce786b,
            limb2: 0x1e3e00bb2656fa02
        },
        r0a1: u288 {
            limb0: 0x5a1e7c910161cf1b9d86492e,
            limb1: 0x19548a3c9750a68ca3d6a790,
            limb2: 0x9a573752cbe57bb
        },
        r1a0: u288 {
            limb0: 0xa601901db968f1972271f27a,
            limb1: 0x7aa051e20616d60c977e3a44,
            limb2: 0x4cfb590ea40ee5e
        },
        r1a1: u288 {
            limb0: 0xc20e8f39d17282d0ef071a26,
            limb1: 0xb42ae86fd39de6e0bbc6e9b1,
            limb2: 0x194482c4a9c006d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa7931668b2d1ada59e040772,
            limb1: 0xbdbbe20621c8913df7eab21f,
            limb2: 0x14d86e5b090702ba
        },
        r0a1: u288 {
            limb0: 0xacd8fa53b4b8ff1992c3ffa5,
            limb1: 0xcc43994e1e1b1fbbb6d96937,
            limb2: 0x2a42f0e33981bef
        },
        r1a0: u288 {
            limb0: 0x275c51eafe4b883496fb7044,
            limb1: 0xc08a185accfbb5090a7c8593,
            limb2: 0xc1d81a243ac31a4
        },
        r1a1: u288 {
            limb0: 0x7fd0942d0575ce7e87ed2150,
            limb1: 0x349fe7bbb1d8715a5d67c67e,
            limb2: 0x1c4bb598453c589a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3b3d72919a71fed294701aab,
            limb1: 0xb15b1befc67929b9118f548c,
            limb2: 0x24025417fdae4663
        },
        r0a1: u288 {
            limb0: 0x48f70f265ccf20d76f1c4ebf,
            limb1: 0xa75ac1a06b3f962693768da7,
            limb2: 0x1db57cd3a40f676f
        },
        r1a0: u288 {
            limb0: 0xd0e60a5f07e3bc99df55104c,
            limb1: 0x7ac90a3dbdbc7b3965d711bc,
            limb2: 0xb0d5f4fb69f328b
        },
        r1a1: u288 {
            limb0: 0xd50184129862a2105605d7f2,
            limb1: 0x4fe764047ccd3d96271b6293,
            limb2: 0x27f4906b0e94b94b
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa48af3f5a79f02d5010d1d1e,
            limb1: 0x7f4aa83c3bfb7620dc0d63b2,
            limb2: 0x15a8245ea8e59ccb
        },
        r0a1: u288 {
            limb0: 0x72cd5c00ca052290c6ddb5f4,
            limb1: 0x111575f0ff6822f8f03c70fb,
            limb2: 0x10c91428950ca8b5
        },
        r1a0: u288 {
            limb0: 0x5f2b82b62052d2f14b24368,
            limb1: 0x3873046a5b2ebd70d3139b94,
            limb2: 0x25d707d7d5f1efe6
        },
        r1a1: u288 {
            limb0: 0x6a259fa0b871a659d449e4a2,
            limb1: 0xd2ed0e7849e8feeb6a8c00f2,
            limb2: 0x23fd710a49ed3a10
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcfc2094d14ec9913706874e8,
            limb1: 0x84cd215e2d81aa02b2a7272b,
            limb2: 0x1c8db81e603f5301
        },
        r0a1: u288 {
            limb0: 0x2020e1343418333ce3f65bc1,
            limb1: 0xecb03047575b7a8d5abcca9c,
            limb2: 0x2366fe6dfe2f617e
        },
        r1a0: u288 {
            limb0: 0x3bcc6184f87e8e217ed814c4,
            limb1: 0xeb432c730ea4456e2849ed5b,
            limb2: 0x2a9944af994ff7f1
        },
        r1a1: u288 {
            limb0: 0xf2aabc0fd36d2024230b9dcd,
            limb1: 0x267290fc37c4e69f5302accf,
            limb2: 0x2ac3e5e44e1bf9bd
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x67dada79442c5969c69da648,
            limb1: 0x281c89abcd13123d1a39a69f,
            limb2: 0x296fe540ab1c77e7
        },
        r0a1: u288 {
            limb0: 0x1da48a9e8ed4b665bdf325f2,
            limb1: 0x59e6c2e151c6657d92b76513,
            limb2: 0x154189167a8b7829
        },
        r1a0: u288 {
            limb0: 0xa79aeffb3726305d781dd564,
            limb1: 0x407687fc0b03e91f8735a6a2,
            limb2: 0x2ecf341d6e9e0af9
        },
        r1a1: u288 {
            limb0: 0x786e8743b6cc399fb72b0773,
            limb1: 0x363747782f16076783f0a2b6,
            limb2: 0x1cd6ff2cd1f5a868
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x29e0bcc70c8e1f9f3eb999f7,
            limb1: 0xa168754c1ef26ca8d984bf7,
            limb2: 0xf67b78a3bbb153a
        },
        r0a1: u288 {
            limb0: 0x4e8fc2b277214d9bf4584458,
            limb1: 0xae122f0cad08ae1d0b8b70a2,
            limb2: 0xa45fadb8e6d92ea
        },
        r1a0: u288 {
            limb0: 0x6cc773d4b20d6c9622951920,
            limb1: 0x59988b776c5801272ab3fa1f,
            limb2: 0x28991d6a7a1f02b6
        },
        r1a1: u288 {
            limb0: 0xd35626571f2f494184d4a15d,
            limb1: 0x8259ddd2ba62d5d47272cedc,
            limb2: 0xa0584a251572584
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb2ee96901331d525386e020b,
            limb1: 0x7df3d0103a414dfc190a0580,
            limb2: 0x298e19e3d3591b0f
        },
        r0a1: u288 {
            limb0: 0x5b3254af706f2c5ad3e67181,
            limb1: 0x544695b249708a37c4d9cece,
            limb2: 0x147d6156e9f0a511
        },
        r1a0: u288 {
            limb0: 0x67d30dc47905c530af5455c3,
            limb1: 0xaeae9a1811b559fdbe2b7e3a,
            limb2: 0x4941fa6518a8a70
        },
        r1a1: u288 {
            limb0: 0x941ccb8ff9a23fac7d98b0b9,
            limb1: 0x79839127653a9b8c67300779,
            limb2: 0x165fba079b6dde48
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x74974b4d6a4df0bb84b66dc4,
            limb1: 0x239345d265858a9748b39539,
            limb2: 0x267b8f2881069f0c
        },
        r0a1: u288 {
            limb0: 0xb51d644d770769cd606c8424,
            limb1: 0x41a7167d9cf9524380b46492,
            limb2: 0x133aa393507bb816
        },
        r1a0: u288 {
            limb0: 0x5103a23575992088d960b9ca,
            limb1: 0xe01381aaa2d64d872c9403b2,
            limb2: 0x2163ad446cf842c2
        },
        r1a1: u288 {
            limb0: 0x50622abe668f6a2d708296bb,
            limb1: 0x13bff2d9292e3f773a1a42cd,
            limb2: 0x2e72d71e0f17fb9
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9672cbcd50c0c70fb43cc861,
            limb1: 0x4600d41dfb4d772d806dbe88,
            limb2: 0x1bcfc914b2adc8c8
        },
        r0a1: u288 {
            limb0: 0x800a2191fd9a6a171cc73506,
            limb1: 0xbd7c15706ff7cb8d4ace72c5,
            limb2: 0x3037b27884ece83b
        },
        r1a0: u288 {
            limb0: 0x5b387b422e26ff6f99d3e512,
            limb1: 0xc62ecf83b7c918770006ce65,
            limb2: 0x269c6ff091b5ddff
        },
        r1a1: u288 {
            limb0: 0xab518ada4d1199549b00d1ff,
            limb1: 0xdd3db5eb0792c95a0ef6dd5e,
            limb2: 0x1e15bda4ddcec3da
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x186432e54f5acbb82947ea7f,
            limb1: 0x103ce1bd875c0f6e513a878e,
            limb2: 0x1c23a46079dfc565
        },
        r0a1: u288 {
            limb0: 0x19b565ab29dfee6aeffc79dc,
            limb1: 0x8f9e2167043ae95745340ba6,
            limb2: 0x13d76de305bcfd48
        },
        r1a0: u288 {
            limb0: 0x6b5f14ec5be0bf6b97cd8a48,
            limb1: 0x60450a0ccbd9c7140a1461fc,
            limb2: 0x10b5cee8dcfb1b36
        },
        r1a1: u288 {
            limb0: 0x34866885ff4fb7357532fde,
            limb1: 0x1ae702e1213c1f0f1a42b80,
            limb2: 0x1382bd6ebd351e67
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x40456ca76b45243cc0ae5ce4,
            limb1: 0xd4f9c4425e6a01c628c3087d,
            limb2: 0x12ab929925ec189c
        },
        r0a1: u288 {
            limb0: 0x27ca66dedbab33071189bd85,
            limb1: 0x985ecc4618fbac8601dadac9,
            limb2: 0x1eb19a52ae0cb47f
        },
        r1a0: u288 {
            limb0: 0x4561caaf802cfa11ff493a1d,
            limb1: 0x32de95fac467e39ba0e61beb,
            limb2: 0x2c4d4b2e93e4573d
        },
        r1a1: u288 {
            limb0: 0x29ddf1060217ec4bb53517cf,
            limb1: 0x5d271e0b7371b572ce52a9c7,
            limb2: 0x280900e94dd23c16
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe78ea8656bcd847b864bf0bb,
            limb1: 0x746c3a26a64e85b87a0aea09,
            limb2: 0x1dfd58372f608e37
        },
        r0a1: u288 {
            limb0: 0x2ebaba71bdd58aa556d4ae72,
            limb1: 0xadf47a7826432f75c6286857,
            limb2: 0x25000e7b8dd5f1dc
        },
        r1a0: u288 {
            limb0: 0x6d9ef2218a26c7ca49a38931,
            limb1: 0x8feadaacdbe9d85384ab063b,
            limb2: 0x24ff08fcbf8e35bf
        },
        r1a1: u288 {
            limb0: 0xa8556e410045b529f61f355,
            limb1: 0xedb91eb28265821100be8db7,
            limb2: 0x2207213712bb3198
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6e68077e29dd93ca3bb34b97,
            limb1: 0x9f9af9270a5d8be3ecbe8186,
            limb2: 0x20e8190c419f3cdf
        },
        r0a1: u288 {
            limb0: 0xd671f951ee74c89204144684,
            limb1: 0xda9636192b1b2fb2522c6660,
            limb2: 0x21d690e453096516
        },
        r1a0: u288 {
            limb0: 0x23dea98ac53cd3873e42ed28,
            limb1: 0xca31482b4d897744d3a71927,
            limb2: 0x10a7f698dabb8c1e
        },
        r1a1: u288 {
            limb0: 0x54306136d112c0d6872f77cc,
            limb1: 0x79635c2c388a3342dd6e0e7f,
            limb2: 0x972fa0c55fabb97
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x470b751d36540e860ad42f1d,
            limb1: 0xb962576662ec5efda9721c6f,
            limb2: 0x882e16dc495fee0
        },
        r0a1: u288 {
            limb0: 0xb73515969b094ed93e19937f,
            limb1: 0xdf59925ff3e700f45cd5a7af,
            limb2: 0x1a072757add53845
        },
        r1a0: u288 {
            limb0: 0x8d86e701b870a80be586af93,
            limb1: 0x38610eb88fa1680959ab2a4e,
            limb2: 0x82d3d8b0b22fad6
        },
        r1a1: u288 {
            limb0: 0x5e9463535a90a2fb16618d64,
            limb1: 0xac8f5f9ef98fec2892bea77d,
            limb2: 0x61967a3844393a5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x25ec88e1c96f2ec597fe1deb,
            limb1: 0xd58d0cb9abe257495100859b,
            limb2: 0xcbcb9c88cf8f905
        },
        r0a1: u288 {
            limb0: 0x78d7e34209e1de0a8225a252,
            limb1: 0xb54bda01275ca703699e9f74,
            limb2: 0xa98c28b17f1a5c8
        },
        r1a0: u288 {
            limb0: 0x7c103a7a23b45dc27ef522ae,
            limb1: 0xf3561ed80af0638b8ea6e9b5,
            limb2: 0x2180c96ba67884e4
        },
        r1a1: u288 {
            limb0: 0x78063846a71a18813b039ac2,
            limb1: 0x9d886dfa2f5252a6f5cb6baa,
            limb2: 0x109dfebaf80d439f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2a011d9d8bdff079e94ea4f0,
            limb1: 0xa43abc9371c15e56bd30d6d0,
            limb2: 0x2fece139e8f3b97b
        },
        r0a1: u288 {
            limb0: 0x773c1d43ae5619ec1b798ce3,
            limb1: 0x5e26d589543abf3d0165bed7,
            limb2: 0x1cd7f2cf750647e2
        },
        r1a0: u288 {
            limb0: 0x50c25614dbc98481c13ccf1d,
            limb1: 0x319ce13fb218e9025afc884b,
            limb2: 0x19744cb83908622f
        },
        r1a1: u288 {
            limb0: 0x4234776d8c4c51fd58ae3b66,
            limb1: 0x8b9983ced37ed28a5d72a2e5,
            limb2: 0x2b19d6cf46f8b6af
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc9193fe640e37a0a8a4fd735,
            limb1: 0x6b38235d0fff7376b2e5b62c,
            limb2: 0x2f79c09135096c35
        },
        r0a1: u288 {
            limb0: 0x7971ffebfe5a315e5af535e1,
            limb1: 0xda45b63505b04f8e28621052,
            limb2: 0x12c519b18e03e698
        },
        r1a0: u288 {
            limb0: 0x9df6fea38a1817e08eb8b6b8,
            limb1: 0xb324d022d9a3180362a3fc6f,
            limb2: 0xb2ed819daf9a438
        },
        r1a1: u288 {
            limb0: 0xa5ab6bd0739202b2a4df3d44,
            limb1: 0xee8ee67f97d74b9eb6575d95,
            limb2: 0x2539b92c45941770
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6522cacd7224e73ee895c4ff,
            limb1: 0xbcc4714392dd2fba656edca4,
            limb2: 0x1167a1156cab4eac
        },
        r0a1: u288 {
            limb0: 0x7752ae385d240f72ca179e8d,
            limb1: 0x29fff69f24464570cf441f7c,
            limb2: 0x4173a7d936de325
        },
        r1a0: u288 {
            limb0: 0x5603a5f367cbe7ccad13ea45,
            limb1: 0x4f7b48ac35bd787dc6a1cf09,
            limb2: 0x27324524c51394fe
        },
        r1a1: u288 {
            limb0: 0xf9545e8dd293553b72af745,
            limb1: 0x9fef44d1e506ddb64131280f,
            limb2: 0x1995d82041b02e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdbf60ec6126df8ae3658abe7,
            limb1: 0x6369fbed9e05568b4fd3167c,
            limb2: 0x24fc46842ce87b7f
        },
        r0a1: u288 {
            limb0: 0x6eff919be2a9a1b81c1e3524,
            limb1: 0x2ce735e2b84b4b141ba7be55,
            limb2: 0x94a0ea712d7a2d1
        },
        r1a0: u288 {
            limb0: 0x6112fec075c6041bc7d3bf7b,
            limb1: 0x41a6d9f4362810f71e13b7d0,
            limb2: 0x10001b7f6da4296f
        },
        r1a1: u288 {
            limb0: 0xa488cf568ec02008f20246df,
            limb1: 0x43909da8441f0c2ecccf5492,
            limb2: 0x2eada4b8fa21c18c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x98ac0820ebc04e4d3d9dedd6,
            limb1: 0x46b082a5dce1ada0c24d405c,
            limb2: 0x257ad3195e40b1bb
        },
        r0a1: u288 {
            limb0: 0x6ac47f5502abf9c9ed05c0e3,
            limb1: 0x767b49926c72851ff7b0818a,
            limb2: 0x31455a20631c1a3
        },
        r1a0: u288 {
            limb0: 0xb4ea5f04b4ed4a2304ecf1ea,
            limb1: 0xe2ff240f28fca5e2c4639396,
            limb2: 0x529c3daa80cfd1e
        },
        r1a1: u288 {
            limb0: 0xc1867617cf7eed052dd8bb4e,
            limb1: 0x98da86340670089e3492c63f,
            limb2: 0x21b06125ec2d77d2
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x406c9d5d6f4e2f7eeb9e4c85,
            limb1: 0x70df4a65af378f0b0943775e,
            limb2: 0x10be30411b81476f
        },
        r0a1: u288 {
            limb0: 0x391033fa9ba7dbb0144ab4da,
            limb1: 0xe7b2bfdef96ab0656c69377a,
            limb2: 0x18ad6e666efdc0e0
        },
        r1a0: u288 {
            limb0: 0xa4fb78dc0b0b591cd866ed4a,
            limb1: 0x97596d021fdec9a8a7cf93f7,
            limb2: 0x2e3a2e04d37a4b2
        },
        r1a1: u288 {
            limb0: 0xb217a59d9aedd31ea272056e,
            limb1: 0xa054ffc80f494e43e1e3c9f,
            limb2: 0x2b9f2b79cd64cd
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9739e25664c89aacac24a1ed,
            limb1: 0x7eeb4309c52c037b09d0b589,
            limb2: 0x18bf965b3e511d79
        },
        r0a1: u288 {
            limb0: 0x39c11ebf07ec1a436c842b3b,
            limb1: 0xa10da4e7d0acaf524a79b7c8,
            limb2: 0x10887fb87169619f
        },
        r1a0: u288 {
            limb0: 0x57fb04114af5b4163e2a7cb9,
            limb1: 0xd69ea86e73bfe08a459932c,
            limb2: 0xe806f0e03c2ae7c
        },
        r1a1: u288 {
            limb0: 0xd4268576fe49eadc154ec023,
            limb1: 0xf4f5eb0f8779045f6b7170a5,
            limb2: 0x2d781d2298d7a954
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x72634216ee67c448ce98e5d5,
            limb1: 0xcd1d92a706c7e610035e35d7,
            limb2: 0x185c5fc9eb74808d
        },
        r0a1: u288 {
            limb0: 0xd50f44bb2e9f1f0ea8cc95c1,
            limb1: 0xea3222f84ab5e7edbe77f014,
            limb2: 0x23e0e7d2153f627a
        },
        r1a0: u288 {
            limb0: 0xbf94f77661f4dd2c5cf069bf,
            limb1: 0xd25e4000d66fc79570bbbc1a,
            limb2: 0xd1a8d878ec24d91
        },
        r1a1: u288 {
            limb0: 0xe62f98d2e723e1031ce0b7d9,
            limb1: 0xc34c0b7ce763448dfc86972f,
            limb2: 0x22d39b096e2bbc4e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x768d659e05b25bb7a736d0c9,
            limb1: 0xfd782b833c16638d44da54ec,
            limb2: 0x2718a04e68eb38ba
        },
        r0a1: u288 {
            limb0: 0xe931cd5713908452534e430a,
            limb1: 0xad861643739c4dd384d4eacc,
            limb2: 0x2695937ac4aeee47
        },
        r1a0: u288 {
            limb0: 0x9a2274762c4b9689de4e99a6,
            limb1: 0x2ee2d2bb2cda0c96c0677732,
            limb2: 0x1572cb6ab0682451
        },
        r1a1: u288 {
            limb0: 0x30f6e574b84e8c36b322da33,
            limb1: 0x80351a34f639c41e134e6f97,
            limb2: 0xfa08e57b19159e6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2d7e1bfc244ad7ce22c41bac,
            limb1: 0x7dade326a3f273da82074b05,
            limb2: 0x2759377809fb4c97
        },
        r0a1: u288 {
            limb0: 0xd9dbee6372916baa1ffe3eed,
            limb1: 0xe474dac3381a98d3646378e6,
            limb2: 0x140793fd3710dc16
        },
        r1a0: u288 {
            limb0: 0x5ed3f3417ee52e402ff70d4c,
            limb1: 0xa5359e7ba784bc7c0324206e,
            limb2: 0x75a33365390cd49
        },
        r1a1: u288 {
            limb0: 0x7512038c0c5c198f73bb2100,
            limb1: 0x1bff7947853ed63ae00c6933,
            limb2: 0x19636be7840ac25f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe417f4d79293c4f5482dc43,
            limb1: 0x84a43b92921ae22a0b2ad3bf,
            limb2: 0xc432e5da5dab8b0
        },
        r0a1: u288 {
            limb0: 0x722f4170fca301a8ae5605bf,
            limb1: 0xb486402c48b859c4a9b17016,
            limb2: 0x16c526d7e323d39
        },
        r1a0: u288 {
            limb0: 0xb7a86327118963e51dea3524,
            limb1: 0xb3ce6a1556640fc419bae40c,
            limb2: 0x25e724d233eab94d
        },
        r1a1: u288 {
            limb0: 0x7891fb6e9ceb4d7d0d12aabe,
            limb1: 0x403572ee780d73fb52c5580,
            limb2: 0x3ebf4bdf26036
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4e668f39edbaa350e6b39cce,
            limb1: 0xdb6a5b1fb2b7ed3596bd63d,
            limb2: 0x163618e3357e06f2
        },
        r0a1: u288 {
            limb0: 0xd5b5897745e78db60f85fa6b,
            limb1: 0x3ffca42c71f8eb0798632c2f,
            limb2: 0x209e116429c00bde
        },
        r1a0: u288 {
            limb0: 0xc301073ca897ff301b88c3c6,
            limb1: 0xeaa01d521722cbd8c890b8bf,
            limb2: 0xe06f0726b6a70e8
        },
        r1a1: u288 {
            limb0: 0x1e188ec39f3bc98f62e5772,
            limb1: 0x269c1a308156dbbddb569f06,
            limb2: 0x20c548fb930b279b
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x58470bd52695f49896f9ccd6,
            limb1: 0x60542158abf2d9e735c3c577,
            limb2: 0x2ef818e63a82690
        },
        r0a1: u288 {
            limb0: 0x9f5243ba0ee5ff9360b16b6c,
            limb1: 0x5b7245809c50880e11729371,
            limb2: 0x1c484cb8e11d5081
        },
        r1a0: u288 {
            limb0: 0x13b3390018e072427df0f42e,
            limb1: 0x47546c82d5ff3acff98497ab,
            limb2: 0x1cb46da0182b197c
        },
        r1a1: u288 {
            limb0: 0xcd09006c4de460a27d46e942,
            limb1: 0x39f36201fcf59ab02975bbb8,
            limb2: 0x1c5267ec884a1764
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xefe17d020151b05417a3ee61,
            limb1: 0xd5417aea1d54de866a7999c,
            limb2: 0x2d74c641d95b49ef
        },
        r0a1: u288 {
            limb0: 0x98dd52c6812d0ae80de743d0,
            limb1: 0xd0f68991fbcb6ebb445606cb,
            limb2: 0x1642ef8bc560d8c
        },
        r1a0: u288 {
            limb0: 0x5faa1529c27c65d8dcd2bb55,
            limb1: 0x7e754b2c52f3e2f650f29001,
            limb2: 0x302c52e0bf7c9830
        },
        r1a1: u288 {
            limb0: 0x3e13df5d6fb96235a1e2f239,
            limb1: 0x9a51a0835aab668f481ecfec,
            limb2: 0x2148019f2853179a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x35f1d95a12e817533f30ba2,
            limb1: 0x244deac23ed6f06dbff459ee,
            limb2: 0x130268ca66426b30
        },
        r0a1: u288 {
            limb0: 0x19924bd057aa6faabfd581b5,
            limb1: 0x61b272acc1e8ef3cfc255cc6,
            limb2: 0x1ae3bc64d7628046
        },
        r1a0: u288 {
            limb0: 0x8c595399dabbedcf3a1902cc,
            limb1: 0xf51d1b25813d17a7d852cf0c,
            limb2: 0x19fd48ec93ac8c7c
        },
        r1a1: u288 {
            limb0: 0x637aa4f5d9c1695a2c984d14,
            limb1: 0x8557587bb37973039060802d,
            limb2: 0x899201889b409f6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xaad80d009c8585a11ea5a6ac,
            limb1: 0x22b0d43c448a7aab54ccb6e8,
            limb2: 0x761f0839f7ebf7a
        },
        r0a1: u288 {
            limb0: 0x3c738c9c831b7418774fc3a9,
            limb1: 0x8b8c2af4ea89f3e289a89bef,
            limb2: 0x2967d111678b05fb
        },
        r1a0: u288 {
            limb0: 0x6f24b256e7550b6d9e8e3534,
            limb1: 0x4252e84d83c41c4ffd5bee5e,
            limb2: 0x2eb08294886ddb8b
        },
        r1a1: u288 {
            limb0: 0x74a61b9984f3eeea17f7f275,
            limb1: 0xde5ce1283f8bf490c36c37a5,
            limb2: 0x29a027531ca786df
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc8a226c334b2d9d78db75ae7,
            limb1: 0xda31ad0d6d56aaeefa92ad5f,
            limb2: 0x23c58839ac26078e
        },
        r0a1: u288 {
            limb0: 0xd0251e7a3e263f004d617a05,
            limb1: 0x74c3e2655d12e332b1a1f108,
            limb2: 0x1454ce118dfb76f9
        },
        r1a0: u288 {
            limb0: 0x8d4caff97a1423e53fcfc99,
            limb1: 0xb3eecfb8e4129bc4ac562155,
            limb2: 0x269b9fa7383db1fa
        },
        r1a1: u288 {
            limb0: 0x552090ef9ff2be21ce08941e,
            limb1: 0xc5953ac9f38023bdf1b8d600,
            limb2: 0x1fa414ad2ef0c547
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x54d0649ed782f2225fe5e390,
            limb1: 0x3d578bff4f805210600e80f5,
            limb2: 0x2a9fe78e037d83d4
        },
        r0a1: u288 {
            limb0: 0xc1cd2fbb58587f51b38f1256,
            limb1: 0x9eea7668993a548a6e012e72,
            limb2: 0xef8bd3ba079ce84
        },
        r1a0: u288 {
            limb0: 0x74232df90e56e2d15984c928,
            limb1: 0x98eab714421cca6a757bf683,
            limb2: 0x1a7e8a9462f7e934
        },
        r1a1: u288 {
            limb0: 0x56de672b0030ae3f7a983c79,
            limb1: 0xe45be8fe12331a6d5636d036,
            limb2: 0x2bec2dff0dbd03f3
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9c9612588802886af756f534,
            limb1: 0xed1c911d9cede75c36f8b4ee,
            limb2: 0xbcbdaed7626b5fc
        },
        r0a1: u288 {
            limb0: 0x71881f69024013845d3b10c8,
            limb1: 0x58cfdc202b9ee1f12789e56,
            limb2: 0x2aabb864123afc37
        },
        r1a0: u288 {
            limb0: 0xa0aeb6c90f63710f0ea1b3f,
            limb1: 0x46b970b16614be47dba39ad,
            limb2: 0x1839613eb0efeb6d
        },
        r1a1: u288 {
            limb0: 0x2fe1355b5501219ad7598ca3,
            limb1: 0x277faa319066703830d9c7dc,
            limb2: 0xb73d6da405af968
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2c942bd75b156d895f2a61,
            limb1: 0xb91bc0b30a14433bb420bb6d,
            limb2: 0xd025a9668c7e1a9
        },
        r0a1: u288 {
            limb0: 0x8bf6fccf8398a3ecde0bb7fd,
            limb1: 0x64b67d7eb140d9c01c839e2c,
            limb2: 0x1895369b335958
        },
        r1a0: u288 {
            limb0: 0x56cde6ffcff288cfb977e00,
            limb1: 0xf269249341401ed19419595a,
            limb2: 0xd17fca9ac394489
        },
        r1a1: u288 {
            limb0: 0xc5f7eabe7819c0a88167a6c7,
            limb1: 0x6ffa08490e40e012fc4fc8cb,
            limb2: 0x11253eb43ef20932
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc9d4d930781adff088de49fb,
            limb1: 0xf0947a92d8cef2e35ba07388,
            limb2: 0x2ca19baf78dbddf6
        },
        r0a1: u288 {
            limb0: 0x695692a04feb8b1eb2e78e4b,
            limb1: 0xfa74f0a007b5d1c33710841c,
            limb2: 0x14835126a6b4f0a6
        },
        r1a0: u288 {
            limb0: 0x86a66f77ab49c93e9f21f752,
            limb1: 0x9c1ebea739ed0e32fb9aa34f,
            limb2: 0x1704168a710875fe
        },
        r1a1: u288 {
            limb0: 0x8b3c8e2bcefec2e5dd1ecf79,
            limb1: 0xdef8c75b9bca0bd2a36bb3e2,
            limb2: 0xe0747489c74294e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbd1ec1245c3b28c1e5c48361,
            limb1: 0xa622113e54957f9f754ae343,
            limb2: 0x22739c69121667c1
        },
        r0a1: u288 {
            limb0: 0xcc6b8826b51d9a078b2313b2,
            limb1: 0x4d0becdb520803ef3893a81a,
            limb2: 0x17d01f5d94018c1a
        },
        r1a0: u288 {
            limb0: 0x3a8175f4710b977e3536d3de,
            limb1: 0x1ffa66b620165654a96d7221,
            limb2: 0x9a2f40a93385091
        },
        r1a1: u288 {
            limb0: 0xcf9d8289f826e0695dbc786,
            limb1: 0xabd0da75f32a2a72a6b9ac79,
            limb2: 0x1ce7d0c554eff9da
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfb55ae49da4c5d3fea3ce066,
            limb1: 0xc3d9735e22394e93c78e755a,
            limb2: 0x9e6720dd761ba3a
        },
        r0a1: u288 {
            limb0: 0xc4a6a6329a9096f006d707da,
            limb1: 0x981d7765e7907b53c6ae370f,
            limb2: 0xc50fde70d92f435
        },
        r1a0: u288 {
            limb0: 0x97d59001126430af3c8e5365,
            limb1: 0x9ef8f8fd281fd1a8ec819c6f,
            limb2: 0x6ba8b139e0896a9
        },
        r1a1: u288 {
            limb0: 0xc4a55e3a517ad7f9b653c1a5,
            limb1: 0x4b5afd8a8bff1215f5cfbab5,
            limb2: 0x18ea25a64fd1e9e9
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd9580428d924d693cc970a42,
            limb1: 0x14c69a0d48a5eeb13295dce9,
            limb2: 0x1c4bbeec9ddd125b
        },
        r0a1: u288 {
            limb0: 0x3b3db6ae9acab46010b4a36,
            limb1: 0xac79be99368096ad361d1fc7,
            limb2: 0x2dd090febd41a78f
        },
        r1a0: u288 {
            limb0: 0xdacd967cc74f3272a140178b,
            limb1: 0xc94f4c0b7506ecf26803228b,
            limb2: 0x13c407bee4f36c9a
        },
        r1a1: u288 {
            limb0: 0x410bedec525df5702bfedb0e,
            limb1: 0x35e6686a72e7eda115dfcfff,
            limb2: 0x15f90a4fd69b7c6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6b865b9aa6be1438ee23646d,
            limb1: 0x2983e00386d5dcb2ba33083a,
            limb2: 0x209f7b13a09efb1a
        },
        r0a1: u288 {
            limb0: 0x3c1bfbc85e6b533b8fc622ba,
            limb1: 0x44c6f59262ead6eb04d4675f,
            limb2: 0x14b1733861328f1b
        },
        r1a0: u288 {
            limb0: 0x5f1c30bcc08691b73ac0881d,
            limb1: 0xa9288dcb01d08c6df72b0354,
            limb2: 0x1f650ab573af20df
        },
        r1a1: u288 {
            limb0: 0x707c96366029dce3b1d18fec,
            limb1: 0x79513abc2add11e4534b64c6,
            limb2: 0x11584e5df9601996
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x75bea1455d5636a45dce1d3c,
            limb1: 0xbc883d985db337b38a08bdc0,
            limb2: 0xc845daab7176ce2
        },
        r0a1: u288 {
            limb0: 0x738af4e8b12492b5d9cf6547,
            limb1: 0xc324b2d83e775695b22af72f,
            limb2: 0x20ccda1d155bf738
        },
        r1a0: u288 {
            limb0: 0x9803598e0cca436c54111eb9,
            limb1: 0x63d1398da0cc8e19d64c0118,
            limb2: 0x2e90e4ca9463b660
        },
        r1a1: u288 {
            limb0: 0xa3311554b7a7cff48b912e89,
            limb1: 0xfe7b5d1a4d87d0b6a77ef293,
            limb2: 0x3f1ea8b7735469e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbff139b8df71ef20254b51ea,
            limb1: 0xd98cb93a4500c7f5efccfda0,
            limb2: 0x63f146a4839c285
        },
        r0a1: u288 {
            limb0: 0xbd3da580eeb2e54e23033e57,
            limb1: 0x1ffa5f58d717a2fa2a2fa615,
            limb2: 0x121f30f0e1779494
        },
        r1a0: u288 {
            limb0: 0x2ea73e8f4d4d76987cb54a42,
            limb1: 0xc0a5c5444148efd31a570152,
            limb2: 0xe7eabaecbc1764d
        },
        r1a1: u288 {
            limb0: 0xb417e5be728ac918e1cc1afe,
            limb1: 0x3eecea5ba8346d11ac355232,
            limb2: 0x2a6f4b91d49027bc
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4a0a936e8f15e38748cabeb6,
            limb1: 0xb13c7f833777b4a9ae18ab5e,
            limb2: 0x11236bb4eb667925
        },
        r0a1: u288 {
            limb0: 0x972e99f4d0f49327f57cab5f,
            limb1: 0xf3879cc613d751e40ec50f53,
            limb2: 0x242108fa827b3305
        },
        r1a0: u288 {
            limb0: 0x514f80e423fd6e782b567f47,
            limb1: 0xfdcbd09ae1d6e13b45418ec7,
            limb2: 0x2b8cf6757e1ce304
        },
        r1a1: u288 {
            limb0: 0x7f9142a98813d462c84b9cb8,
            limb1: 0xb68e693862b8c3ebd56a4575,
            limb2: 0x268ea5819fb1681d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa7f6f798813632a974c45ee1,
            limb1: 0xc0f7beec1688e075af65a73e,
            limb2: 0x89b6794c651648e
        },
        r0a1: u288 {
            limb0: 0x6424994b84365731e09428d2,
            limb1: 0x8065dddb310f0e1e2a201b4,
            limb2: 0x12d8547e8617d75b
        },
        r1a0: u288 {
            limb0: 0x3d553b682fb052865554aa1f,
            limb1: 0x929c1404bc22f8d37ab48be3,
            limb2: 0x2130c5fab591ec37
        },
        r1a1: u288 {
            limb0: 0xf7a543869f47ed8fd5ea4c70,
            limb1: 0x3687f0782216d7fa3cc3d175,
            limb2: 0xe1e250f14be18fe
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xba1731ccd3885dd606c5b87,
            limb1: 0x4109574ac7d361afd5531dd3,
            limb2: 0x2d9d35c305189f90
        },
        r0a1: u288 {
            limb0: 0x87f8b42a0e90fb48fe9283f7,
            limb1: 0xbbfc1950b993535fdcf0ad96,
            limb2: 0x7953da53939104d
        },
        r1a0: u288 {
            limb0: 0x2b2fb441ff55afcde43887aa,
            limb1: 0x3960c2f46d87171b412f48ec,
            limb2: 0x7de0ceca0b90b1e
        },
        r1a1: u288 {
            limb0: 0xa261106131fe7169f10f6992,
            limb1: 0x1acec5ece98b6359da2e2723,
            limb2: 0x1d951aa232050828
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x11726c7eb325949bcc2b3f65,
            limb1: 0x9f214ac0d26492dec207b44f,
            limb2: 0xf027a5e639bf731
        },
        r0a1: u288 {
            limb0: 0x4e61d4685194ba1da9545327,
            limb1: 0x261a52635817994c7d810bf3,
            limb2: 0x1bdfb8139ef9ef9c
        },
        r1a0: u288 {
            limb0: 0xea4b7edcb26cdf2a655dae94,
            limb1: 0x65ff199676c530a06417c767,
            limb2: 0x2e45f1c9d0c29afb
        },
        r1a1: u288 {
            limb0: 0xfad66c1c746bf30a93458305,
            limb1: 0xf3af3d7b669e484b917cec7e,
            limb2: 0x183bc1a4bafa633f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x61d9b7e4b113b8ec287cb9d7,
            limb1: 0x885d259961c00deff3e50a1c,
            limb2: 0x2a985454ddedc36a
        },
        r0a1: u288 {
            limb0: 0x2b5b491812ee16aaeba23cf7,
            limb1: 0xf06437af521dbe73e1492e5c,
            limb2: 0x117a194e7b3a43e
        },
        r1a0: u288 {
            limb0: 0x3b867354c4b5be1e05402c09,
            limb1: 0xe50df6247ea53241cc037229,
            limb2: 0x1a0af622322bfa69
        },
        r1a1: u288 {
            limb0: 0x3a471146b323ae428209b583,
            limb1: 0x61cb2078d8ff25411714f2c9,
            limb2: 0x15fa72f5592276d3
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x564cc91b3b51a02535a73096,
            limb1: 0xb3f49b1de20b288751af681a,
            limb2: 0x24d7fcdea03c5610
        },
        r0a1: u288 {
            limb0: 0x400f675377c9fd08865a27eb,
            limb1: 0xc94e3b6075b602b5c8226846,
            limb2: 0x6fb35d8290ae836
        },
        r1a0: u288 {
            limb0: 0x55a0bdc7a639bee54aee5c2a,
            limb1: 0x7227ddc37e65672bb5f00dd3,
            limb2: 0x1f744968954a06f3
        },
        r1a1: u288 {
            limb0: 0xe354a5002d36c4ef6fe0dbb8,
            limb1: 0x7614af1a033ab0db195e236f,
            limb2: 0x4bbd8c41f29693c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x38a7586f904ef0d67737e5f9,
            limb1: 0xede7dda0a83a6c39da16c45c,
            limb2: 0xde4c1afcfe7a1e9
        },
        r0a1: u288 {
            limb0: 0x9d212bda45f0930640ebfeb0,
            limb1: 0x65797724d7d6bbd9fe9eac00,
            limb2: 0xf3c97befe3336a2
        },
        r1a0: u288 {
            limb0: 0x701e7a69d1ad0bba7bc56033,
            limb1: 0xbfe40129ac64bd3bdc3a7c9,
            limb2: 0xb6016b13bc0f66e
        },
        r1a1: u288 {
            limb0: 0x36475d8d9faf482b111c33ad,
            limb1: 0x6d15d0b6fb55e4670acc4169,
            limb2: 0x22c01e45d549d339
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3e33d32d91bae526d4a26f42,
            limb1: 0x9443bdf9c2363c448db392db,
            limb2: 0x20bb3ec5cf88bf1
        },
        r0a1: u288 {
            limb0: 0x501552c425371c2e1bb731eb,
            limb1: 0x513d9ebcefae11ba4356453e,
            limb2: 0x517a8046b990d26
        },
        r1a0: u288 {
            limb0: 0xa252d00772970d991b088e57,
            limb1: 0x38562600ce56643fd83c7d28,
            limb2: 0x1d1136463f0bef13
        },
        r1a1: u288 {
            limb0: 0x7a96689dc28658565dd3758,
            limb1: 0x811dc31cbc0ee9e77762ff6d,
            limb2: 0x17a298bf138ccf82
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1e14e805dfaa7b89cd9329b6,
            limb1: 0x2934034314bef9e3deec9dd5,
            limb2: 0x191e9e0bfdfba93b
        },
        r0a1: u288 {
            limb0: 0x7732a7d462ceeaa050a4e57f,
            limb1: 0xb198874b04aa310c9ccddd9b,
            limb2: 0x2301cde807f255a3
        },
        r1a0: u288 {
            limb0: 0x1df23ff6a5f6c8310c95c26f,
            limb1: 0xb1a171320b2f953738f57037,
            limb2: 0x19953f576393962f
        },
        r1a1: u288 {
            limb0: 0x9d9578846244e9962f6e9a91,
            limb1: 0x8eed88427aa7052dd664d485,
            limb2: 0x1e3ef05fb608a38a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc0e8e985da1c5414ea5a4f69,
            limb1: 0xf8071a12cca37c43e9912229,
            limb2: 0x1373be4728e82697
        },
        r0a1: u288 {
            limb0: 0x1bcd23aac980c6534b3a096f,
            limb1: 0x3731efedc487780812d68cac,
            limb2: 0x65b04a9708c7ac3
        },
        r1a0: u288 {
            limb0: 0xa63085cde7feb44e49d211c3,
            limb1: 0x5dabacab65da5ceb3c5fab6f,
            limb2: 0xaae5bccaa202786
        },
        r1a1: u288 {
            limb0: 0xc967c2766fefb3cb9ecc0d60,
            limb1: 0xc9a98de5017502b46918b522,
            limb2: 0xfa05e98c9c8d5b8
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3e8e827e8dd61e0f449195bc,
            limb1: 0xc4c7cd887ee1638ae083e9e,
            limb2: 0x1af4c870616aae98
        },
        r0a1: u288 {
            limb0: 0xa69ab086c01e2c7d16710104,
            limb1: 0xb2d2a0a807adc5dd464f341b,
            limb2: 0x1eaa47df126fa6d4
        },
        r1a0: u288 {
            limb0: 0xf8c3e84c684abbfc24f8cc02,
            limb1: 0x96a69d71d26c888417fb8bbb,
            limb2: 0x146cc83705844b00
        },
        r1a1: u288 {
            limb0: 0x426bc89a4e0febcd507509b4,
            limb1: 0x7b57eea7b12ec35b3b905215,
            limb2: 0x8308749e9c1ac81
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xddb41553d06059c9f4647e12,
            limb1: 0x247c596040d28418f659fef8,
            limb2: 0x2695ccbb8809ad78
        },
        r0a1: u288 {
            limb0: 0x1e6c6f187837512cec01bb25,
            limb1: 0x49a81582bef6fab9f825f8e9,
            limb2: 0x23e66c85b3b459a8
        },
        r1a0: u288 {
            limb0: 0x8abc91c75cb605af2181299,
            limb1: 0x7021335abed9cca06faf4b72,
            limb2: 0x155a426a15a8d10f
        },
        r1a1: u288 {
            limb0: 0x8e29e534df6e12f205039a2,
            limb1: 0x9acf75cee09284780cc4103f,
            limb2: 0xac4e19051726b02
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7dbb403d40dc660b36037980,
            limb1: 0x89a53d3b7547614705f18642,
            limb2: 0x73529fbcc02d3e0
        },
        r0a1: u288 {
            limb0: 0x16db5fe343bb93ace7dcfaa2,
            limb1: 0x2f7dd5e0693237e46e1b73fa,
            limb2: 0x5c86018c5cab38
        },
        r1a0: u288 {
            limb0: 0x8f456ab4a176f94c18c76523,
            limb1: 0x87f5aa05e73db8a11028563e,
            limb2: 0x1c427d9febb8a613
        },
        r1a1: u288 {
            limb0: 0x16e45ed4c1a37b79b5efaa3e,
            limb1: 0x63beed14799b61c436710693,
            limb2: 0x9da5553f63ccb49
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb62dd03db04bd7d0271e79f7,
            limb1: 0x6c7d7760a0382e3796755ec3,
            limb2: 0xe7490cd6508967a
        },
        r0a1: u288 {
            limb0: 0x4ebfe2d6ccea48ed33efc548,
            limb1: 0xc1c1ad58e43a9e5c12e3f0f8,
            limb2: 0x2c14edf60dca8309
        },
        r1a0: u288 {
            limb0: 0xd02e0339dce30bc427e88992,
            limb1: 0x3bd4afa4c16e7b1b824e5be2,
            limb2: 0xbdbace2233e2ee2
        },
        r1a1: u288 {
            limb0: 0xb87d9cc7ea54dacee9dd8ab1,
            limb1: 0x682be5c0f69984ed881cc36a,
            limb2: 0x391f9e97e2e1e7d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3caf1eb1d3ee0f85de041fbf,
            limb1: 0x2cc07c40cfa98dd8280c8760,
            limb2: 0x22047132388ee574
        },
        r0a1: u288 {
            limb0: 0x3853dc42b4776a1682ecf64e,
            limb1: 0x5c0f87a59d1b45d9eb1389cd,
            limb2: 0x366978366039c0
        },
        r1a0: u288 {
            limb0: 0xcaa176f5471e2903d076eb6c,
            limb1: 0x4769b535a4dcfd5f2d9411cf,
            limb2: 0x2e34b0e4cfa806cc
        },
        r1a1: u288 {
            limb0: 0xc632583dc1e5a6c499cedee2,
            limb1: 0x56d311c25e3faf074f9cc569,
            limb2: 0x1ee6f097c13651ba
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x628a63397f4593b5ba583ba0,
            limb1: 0x1dfdcbd68ba41aaee36e3c49,
            limb2: 0x11d6ed5ced3c913f
        },
        r0a1: u288 {
            limb0: 0xb91d44e7e6aa989a83d25ced,
            limb1: 0x17a3c357f6d9307b9010abf3,
            limb2: 0x1022d83c36ac39d3
        },
        r1a0: u288 {
            limb0: 0x9eea316536e58608a9b7508f,
            limb1: 0xab56f5feb76354cf11930937,
            limb2: 0x1d13b20e87d9d2f5
        },
        r1a1: u288 {
            limb0: 0xd85ee8753bcb342a7636cfe3,
            limb1: 0x5d7d4dc90f175e6ad960daca,
            limb2: 0x16ad224ba5ee8b3e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x960e725cbcdf5e0a34c3f489,
            limb1: 0x2e29ae6966336f2a904bd747,
            limb2: 0x6fc8a7da1370134
        },
        r0a1: u288 {
            limb0: 0x384272f62b5c8cb709a9a92f,
            limb1: 0xae5653a3dac65d20c5aca450,
            limb2: 0x1f122ed1dfc2af58
        },
        r1a0: u288 {
            limb0: 0xd05f3bd05f74eb216038bdbe,
            limb1: 0x2a8a0e29d647dcd4d08cc467,
            limb2: 0x174066a33db0e666
        },
        r1a1: u288 {
            limb0: 0x2d0084246e66fa111c18344e,
            limb1: 0x5b4dbb8601508c2220438964,
            limb2: 0x1f87d00177b8ff56
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb8e986d327be82de871eb21e,
            limb1: 0x98ce46b3ce82e6740ec11b91,
            limb2: 0x17671553b188e889
        },
        r0a1: u288 {
            limb0: 0x373f2db1ff5340fc24b96e60,
            limb1: 0xda22e9d018ba83de57415f74,
            limb2: 0x12586536be31fb9a
        },
        r1a0: u288 {
            limb0: 0x10661798f1d7cca360ca1031,
            limb1: 0xc3df66e3f5447f62b7cb2ee,
            limb2: 0x2506751ec4bf0a93
        },
        r1a1: u288 {
            limb0: 0x497d9639b00f4bf048c322ce,
            limb1: 0x1232209471ae4551804bfa21,
            limb2: 0x2bc208670e6e5f4e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x10f1c9e33a814e7195441d41,
            limb1: 0x8efcc55f3aa3868195ad2b4,
            limb2: 0x1df987c0fec15ef8
        },
        r0a1: u288 {
            limb0: 0x4693df68c3a67289fee74fd1,
            limb1: 0x1b042ebd4ea599811b91ff35,
            limb2: 0x115549dfe6dbdbc
        },
        r1a0: u288 {
            limb0: 0x18af853c787d5c6bc7815c3d,
            limb1: 0xc8bdfb93139ce00be9a8c9a3,
            limb2: 0x197ef6308ced3e23
        },
        r1a1: u288 {
            limb0: 0xe30de333992050cccf89ccad,
            limb1: 0x6f0e99a0268adc0840ddaa8a,
            limb2: 0x13e33d8bc164b1a5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6b3df5984947f0b30fb75ea4,
            limb1: 0x9fffce2c560a816f143ff7e,
            limb2: 0x21dc3e637c4c383d
        },
        r0a1: u288 {
            limb0: 0xba028cc7a249b47293727c22,
            limb1: 0xa62016c4377e2dc023eb8edb,
            limb2: 0x1b4cfabf48425319
        },
        r1a0: u288 {
            limb0: 0xb38f5d29bc58981474447a84,
            limb1: 0xff50d2c617ce34fe73cbb785,
            limb2: 0x999feea8b79ddfe
        },
        r1a1: u288 {
            limb0: 0xae323610299992f01736d2c9,
            limb1: 0xd4b58f7ca463fb21ed392a35,
            limb2: 0xe5f5cfe3fc5811f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x16a90d44af8d7dbbdde0f4aa,
            limb1: 0x2bd056555b7105b9757caea0,
            limb2: 0x2fff38bcb872c22f
        },
        r0a1: u288 {
            limb0: 0x69656c4fa844f208697542a4,
            limb1: 0x4e2a55fb2afcc59be109b176,
            limb2: 0x435a1e825f48149
        },
        r1a0: u288 {
            limb0: 0xeeda9f2dab58f47045c2ac44,
            limb1: 0x4688f1adaff6b6f13796243d,
            limb2: 0x2e20bf9ca0e2e566
        },
        r1a1: u288 {
            limb0: 0x77c40d0daa89472ff4b9ff8b,
            limb1: 0x98b010aa94d7aec80c82dc54,
            limb2: 0x23886849ef0c6fb0
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1bf6e0aebedfb4891617c9fe,
            limb1: 0xcc8f1faf9afe134049a6f7,
            limb2: 0x6ce1d9504d40972
        },
        r0a1: u288 {
            limb0: 0x6f5c575ef17c71b60ec643b4,
            limb1: 0xb0777c962b74087212a92698,
            limb2: 0x367098200faa8f9
        },
        r1a0: u288 {
            limb0: 0x6e3a8fdf3af9bf79bfe8cebf,
            limb1: 0x311afc0ec50785c2892f3a7c,
            limb2: 0x1757f3e47ba9a245
        },
        r1a1: u288 {
            limb0: 0xe1a3f870428ef6fa188740c6,
            limb1: 0xe08870c8fcbb7498e6f0988,
            limb2: 0x1f72ceda04d3e23a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xce391f6e03b885bd24ddf947,
            limb1: 0x9078112242e1f437565a027b,
            limb2: 0x11813acc64bf739d
        },
        r0a1: u288 {
            limb0: 0xde60f9c7f5cd73d95ee72c6c,
            limb1: 0x9f6184f795dc462511bc12e7,
            limb2: 0x1e3ad3cb946abf61
        },
        r1a0: u288 {
            limb0: 0x310d327d7ccf8ee7d4a3ec99,
            limb1: 0x8a43391ac968bacdc5fc42f6,
            limb2: 0x10dfd0818ce016cb
        },
        r1a1: u288 {
            limb0: 0x189b3989007258718cd7ffb9,
            limb1: 0x6062bd6b22f4154fb2903356,
            limb2: 0xcd76e427cf8119e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4c3c170c270a118096ae9b4a,
            limb1: 0x62386c957e664e69ec6d3e64,
            limb2: 0x2222722a39c41427
        },
        r0a1: u288 {
            limb0: 0x2be5b53b5392de54890f4c6f,
            limb1: 0x254a62302d9c41256f5c0cd7,
            limb2: 0x89a63d30f70b184
        },
        r1a0: u288 {
            limb0: 0xa2d0221de52101a347a33ae2,
            limb1: 0xdedfc9053a5dc42835d87a59,
            limb2: 0x1fc52e0954168351
        },
        r1a1: u288 {
            limb0: 0x9fe51dded874ee39bedaff3,
            limb1: 0x510563357724dae736c41a24,
            limb2: 0x2a4efeccbe81e7bc
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9f12d4a49aeed9039156ee2d,
            limb1: 0x476edc6ef72f7d95cb4cc261,
            limb2: 0x29d97255e69ab7c1
        },
        r0a1: u288 {
            limb0: 0x8bea4e48672b32b49c6fa19d,
            limb1: 0x544a5983350ef8a50d422217,
            limb2: 0x21c25f4506443c34
        },
        r1a0: u288 {
            limb0: 0xce0ee869996d8e37bf77465b,
            limb1: 0x7c7787b12b89a39c711aa855,
            limb2: 0x1cdd1ef257dba72d
        },
        r1a1: u288 {
            limb0: 0xf20d5413e7057405c5118b4a,
            limb1: 0x5608ac448fc6d054373d7dd8,
            limb2: 0x2f060367f6581bf9
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x38fd1509d27f6271c2d633d5,
            limb1: 0x6ff5009dd53c3207ddbcd529,
            limb2: 0x121055840fd24d8d
        },
        r0a1: u288 {
            limb0: 0x463638a44a56aa361b8b509c,
            limb1: 0x4fda3d70baef24ed42ffa73a,
            limb2: 0x12792c1bd0463a5c
        },
        r1a0: u288 {
            limb0: 0xa58f86fd9da3424dea7ff7a0,
            limb1: 0xea4b3240591dee14d8321b0a,
            limb2: 0x2ffca6d546c42faf
        },
        r1a1: u288 {
            limb0: 0x22a0930482be281ed317a44e,
            limb1: 0xb1f8236c4eda46f6223e38d9,
            limb2: 0x153215a2e9d1b758
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x8809c772f76484991cf75b13,
            limb1: 0x69685057d94d90cc0a504039,
            limb2: 0x3397bc6bf639587
        },
        r0a1: u288 {
            limb0: 0x3da2dcd9c9c4c353fe922ecb,
            limb1: 0x514fb8d00890d8cf9f803c2a,
            limb2: 0x2d2ecae822933a8
        },
        r1a0: u288 {
            limb0: 0xcb98210c74bdca0281d53794,
            limb1: 0x7d12bc3647a94848cc3c257,
            limb2: 0x2821d79bf43563d8
        },
        r1a1: u288 {
            limb0: 0x20ebb43be2a83c690378628d,
            limb1: 0xbf3db27da71368c4217ceefe,
            limb2: 0x2c3b9988f02f623f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x96c4d56fd855d6d4a2e11f3d,
            limb1: 0xe452c63af5c55b9e353ab50f,
            limb2: 0x66af7ed9585490
        },
        r0a1: u288 {
            limb0: 0xe9ba28501b5978d1a738c671,
            limb1: 0x335da11e02e62d1d81643a74,
            limb2: 0x20cea3df234070dd
        },
        r1a0: u288 {
            limb0: 0xe7980d21d0e85c4189e11c1b,
            limb1: 0xe105d27c7b2e3f1cab9e53b2,
            limb2: 0x113e2ceb35da5375
        },
        r1a1: u288 {
            limb0: 0x677bbd0dbe6f5371cb1ecbd0,
            limb1: 0xba8eb3a2751d7e96945cf5ab,
            limb2: 0x2c0c41b674408481
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x927b99081bf3c7f038406961,
            limb1: 0x68328db60448c5c877097a51,
            limb2: 0x1600ee7086cd0336
        },
        r0a1: u288 {
            limb0: 0x5b13d9829ceb60a5a38ce85a,
            limb1: 0xe8be88c0a791c1900b006b20,
            limb2: 0x1c8b9e233c1cf8ef
        },
        r1a0: u288 {
            limb0: 0xed3691fbaed43b124b326b53,
            limb1: 0x3ae3e88cee46220cee4a48a3,
            limb2: 0x2f9e0ee37697b32a
        },
        r1a1: u288 {
            limb0: 0xda1fd94ba65c3e7b86c524c2,
            limb1: 0x1a214a21d33dbbaada7fa6eb,
            limb2: 0x2adcb0d612495649
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7bab4674886eea9ff98cf24e,
            limb1: 0x7ad3c5545850d03a0f0cadc1,
            limb2: 0x1f95f0bc99ffdc93
        },
        r0a1: u288 {
            limb0: 0xa4e8953435ffd6bdc0b737b8,
            limb1: 0xade5df1c3b4c7e33af56f0b7,
            limb2: 0x5fa7ed60af9dbd9
        },
        r1a0: u288 {
            limb0: 0x5f321f80450d14eeccfd2eb9,
            limb1: 0x2d8020243141992bbbafcd4e,
            limb2: 0xd0c69f2d2888f0f
        },
        r1a1: u288 {
            limb0: 0xdfc651a76f1a6097fbe1c4d6,
            limb1: 0x9720e08bfe9a08ecdd1bff52,
            limb2: 0x19ef33f74608086d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x13f8d33bbad13856e1bc39a4,
            limb1: 0x16ff19795f3836a066f0ff3c,
            limb2: 0x173d1f768fa994da
        },
        r0a1: u288 {
            limb0: 0x90f12a73071f7e5fc50f88ac,
            limb1: 0xaff694927256fc98d1863f12,
            limb2: 0xa7d74cb02fd7e93
        },
        r1a0: u288 {
            limb0: 0x67062a11341a09ec0df154c2,
            limb1: 0xbfac165c82d9198817b2c2ac,
            limb2: 0xc3e44fab3370520
        },
        r1a1: u288 {
            limb0: 0x7bbc0714cb1a1bc24a2dc182,
            limb1: 0xd13f2607e891e41809579c34,
            limb2: 0x1017d5a3c7c5ccc7
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4944b2c2973a6b2ad47ca12,
            limb1: 0x6caf8025881f4db75a4c6b3d,
            limb2: 0x1fa14019fb49747e
        },
        r0a1: u288 {
            limb0: 0xf1e49b486f029a43eb255fca,
            limb1: 0x1468ff74446293a8dd0dcd0e,
            limb2: 0x2a094cb085bd6b26
        },
        r1a0: u288 {
            limb0: 0xab7673b1804a09434479b2a9,
            limb1: 0x3a6ef8737aab455c8b1fb6ea,
            limb2: 0x25da16ac9bd81063
        },
        r1a1: u288 {
            limb0: 0xf93562b13f79cb24ef049b86,
            limb1: 0x158517eb0d05b58e59c325e7,
            limb2: 0x188b268e614b6a59
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa684ea17ffadee10a150fb7e,
            limb1: 0x9881b6e43d43892e994e0257,
            limb2: 0xbcbf707361d024b
        },
        r0a1: u288 {
            limb0: 0xb3f8894e40728a02a7ddad21,
            limb1: 0xe617e730113fc280e5d3179f,
            limb2: 0x2526ecfb3fa4377a
        },
        r1a0: u288 {
            limb0: 0x1ece7ab467c39adf7b5e9fd5,
            limb1: 0xa5a22bb2c1abe1e6d37d37bb,
            limb2: 0x1c7644867b60fbf9
        },
        r1a1: u288 {
            limb0: 0x30e102449d158c2946c2514,
            limb1: 0x431880a543e81993e3a9159d,
            limb2: 0x2bd4761690aa24df
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x43f99c173aa8076062073c4a,
            limb1: 0x2511731738b87fdb38b6b803,
            limb2: 0x218bd048c66b51f0
        },
        r0a1: u288 {
            limb0: 0x98479e4b980cf31e10bc62ae,
            limb1: 0x8b66b939f42fdc1aff4e56b2,
            limb2: 0x1de1775e1995f781
        },
        r1a0: u288 {
            limb0: 0x953dfd50e06c303672ba67db,
            limb1: 0x17867bcd7e34875fc82452b9,
            limb2: 0xfbbbc51eca1c6ce
        },
        r1a1: u288 {
            limb0: 0x6ca4c5d1f011c4a7aa898a2,
            limb1: 0x229be979e072bf421537fe23,
            limb2: 0xcc380802aa3e905
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa9d6922b3c11ff3be46ae9f0,
            limb1: 0x3a69ae364d7f8bd73bf2d372,
            limb2: 0x2add97dca6fbc39
        },
        r0a1: u288 {
            limb0: 0x416bc979a59aeb1045efe47d,
            limb1: 0x4b220a5c5354b1ff68f33746,
            limb2: 0x273bc662dc9192d9
        },
        r1a0: u288 {
            limb0: 0xc8a67aa26bff30ce25aa40f8,
            limb1: 0x2bc67a20c0d4f1ee1493b815,
            limb2: 0x15845aad1b92dd5e
        },
        r1a1: u288 {
            limb0: 0x5f903cefc9258846bf13f692,
            limb1: 0xdd87a6835c25a4f026282f4,
            limb2: 0x305837bbe4e87fb2
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x994f332ddea873182255e882,
            limb1: 0x1924f41672e976c2bba0f1a6,
            limb2: 0x23c7b106dea6b522
        },
        r0a1: u288 {
            limb0: 0x223ddd21162540e135179188,
            limb1: 0xf5ecc67dbfa16df729822f0e,
            limb2: 0x30530e3044622770
        },
        r1a0: u288 {
            limb0: 0xf9d3cc9cedf595da76149fe6,
            limb1: 0xdf953ad9e09532e3741fcf1a,
            limb2: 0x1beb90ef7d9bb2c
        },
        r1a1: u288 {
            limb0: 0x4dee10fc2b07e26fb20277,
            limb1: 0xb9d6b3a0dd0a013f93780049,
            limb2: 0xe81f615508b06f6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe7954bca4754777ae58acc8c,
            limb1: 0x331833549fb265f3acb0de81,
            limb2: 0x21941dff39e9b884
        },
        r0a1: u288 {
            limb0: 0xe794c63babaaa33c1b7aeca2,
            limb1: 0x961d30110a276213f8033587,
            limb2: 0x129b9e21d72a6c92
        },
        r1a0: u288 {
            limb0: 0xeba9f6f581c325f20c246499,
            limb1: 0x3198b40cd19d01857ecec344,
            limb2: 0x2086da1161e96f82
        },
        r1a1: u288 {
            limb0: 0xfa52d250759e472b5c918df5,
            limb1: 0xe5d1f85b08147696e937a75e,
            limb2: 0xced28fa732f69be
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa898f304465201c63dbbf24d,
            limb1: 0xee3c2988fd98805577ec86df,
            limb2: 0x7a0d9615658ca39
        },
        r0a1: u288 {
            limb0: 0xa25e2bf78388d142578a8943,
            limb1: 0xf97ebe7bfef2a4be83f16d57,
            limb2: 0x1891c9022415c4f0
        },
        r1a0: u288 {
            limb0: 0x92c831a9266131e28227640c,
            limb1: 0x67121e2ecae7c0acbd8ae684,
            limb2: 0x22852f279d2a1013
        },
        r1a1: u288 {
            limb0: 0x835344d255dfba037899fc89,
            limb1: 0xf483e8a31d752458f06499b6,
            limb2: 0x1eeb30c3821947ed
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe9f27b1db65f81977ed12c3,
            limb1: 0x34a04d62c3b7416f3d2976d0,
            limb2: 0x222fc87bb776390b
        },
        r0a1: u288 {
            limb0: 0x29ecd3631d10dd711f5a168d,
            limb1: 0xf08cf2039c13dcb5cac31822,
            limb2: 0x19eee61e1f0036d6
        },
        r1a0: u288 {
            limb0: 0xfb5f7fab93f877e15f107827,
            limb1: 0xf7a6c37dbf031b4d8e1d0271,
            limb2: 0x24f67ca9953e2bc9
        },
        r1a1: u288 {
            limb0: 0xb449576061c138e8f5213868,
            limb1: 0x34ddb6decd35e484a5ff6fba,
            limb2: 0x119fcb252cc1dad2
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf1a4c2645814a6755bdc997b,
            limb1: 0x32d7c3a0c3fab9f9a03540bd,
            limb2: 0x296501beaacfa9e9
        },
        r0a1: u288 {
            limb0: 0x5c52796fe39885b3d6ed5993,
            limb1: 0xfea474a9fb16e0ac09251998,
            limb2: 0x282a35093c51402a
        },
        r1a0: u288 {
            limb0: 0xdad4fafb9245855415a6e555,
            limb1: 0xe1fda405f7e515f5aec996b7,
            limb2: 0x30edff0d4d3cef2
        },
        r1a1: u288 {
            limb0: 0xf6017b086c5d94fa8c4cb88a,
            limb1: 0xbcfd04170a2ca8a5bd43a726,
            limb2: 0x13069d366f8ac0b8
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x595ecc81cac8e8350e2e6287,
            limb1: 0x8ef0bb5abc1b9a53eb08a447,
            limb2: 0x249835ce81793ed3
        },
        r0a1: u288 {
            limb0: 0x4dcf277acbcee8333b3ff7c1,
            limb1: 0x8b4e09aae03cce26559f3896,
            limb2: 0xcddd7004a7e57ad
        },
        r1a0: u288 {
            limb0: 0x8e902b0e6f31d8775fbe1ce5,
            limb1: 0x6cdf52136ab1dc7a0ee90e48,
            limb2: 0x28538597c1edeca
        },
        r1a1: u288 {
            limb0: 0x82d8e55cee8a2ab0f154f2e1,
            limb1: 0x243a1c6fdcb37724c4899486,
            limb2: 0x1a819819bdd0502e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf8f7d25e6782acf7cd4b8885,
            limb1: 0x9d60219ce586aed0c4653bf0,
            limb2: 0x1c4e02d487de74b1
        },
        r0a1: u288 {
            limb0: 0xd3354b0fa2e901146aef737a,
            limb1: 0x2351a84935f11446bb64a360,
            limb2: 0x19bbd507d32a0ff0
        },
        r1a0: u288 {
            limb0: 0xb450293895f32b6dff1b8073,
            limb1: 0x4ebd6f7dd9ac805efdda966f,
            limb2: 0x14d0d1ea23f08d4f
        },
        r1a1: u288 {
            limb0: 0xa7649a2d799254f8a5956cc1,
            limb1: 0x18fce610f81d85e1ab47418f,
            limb2: 0x1f17dba39adf90b6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2b534cecde2e385d1d7c139e,
            limb1: 0x52800be7084ebe0eb3014909,
            limb2: 0x1a23c449f2e16bd3
        },
        r0a1: u288 {
            limb0: 0x9395c0eb42b6bb58c57f6429,
            limb1: 0x3c110379a1f54223b5cf72bf,
            limb2: 0x67340db13d91f37
        },
        r1a0: u288 {
            limb0: 0xd0b6a2cf7eada310133d6e34,
            limb1: 0x2226318d2725d7c1a7602c07,
            limb2: 0x2a64b1381d714f3b
        },
        r1a1: u288 {
            limb0: 0x4cffd950d6ca68e200a4d1a2,
            limb1: 0x246874726c2f77842f0e62fe,
            limb2: 0x82db995fe789ca7
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x77c9a5dd9e88e8ad4d44dc7e,
            limb1: 0x1a61f8ef03a8fe3f6d2c09ac,
            limb2: 0x4f4072d06d11b03
        },
        r0a1: u288 {
            limb0: 0x35ae99e4a84b6d8ffec349f7,
            limb1: 0xc8322ff2db8e4588134607a7,
            limb2: 0x24c4e535006944c5
        },
        r1a0: u288 {
            limb0: 0xe99601fefaee24748937eb0d,
            limb1: 0xe58dfe3d045ef4bda1e6cb4e,
            limb2: 0x2e9893f6c71790e6
        },
        r1a1: u288 {
            limb0: 0x49b15b551f9893aee2313a79,
            limb1: 0x4318b0689b0afa2367055dfd,
            limb2: 0x18fb6cfd6bf95da6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc6be572e8368dd7d9f70996e,
            limb1: 0x984bde35b4ebc3453de5834a,
            limb2: 0x264073e8009963c
        },
        r0a1: u288 {
            limb0: 0x82834790a813e0897b09d29a,
            limb1: 0xc2427a4edcd3d3f27a214510,
            limb2: 0x117a0cdda936af40
        },
        r1a0: u288 {
            limb0: 0x3b5ed6e807031f410a68f9e0,
            limb1: 0xb7dbf598752f645ee23bdcf5,
            limb2: 0x1885d77122935b68
        },
        r1a1: u288 {
            limb0: 0xc4bc08679e5e64f2be7af296,
            limb1: 0xa007f70060eea302261574cd,
            limb2: 0x2570bd28781fbc24
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x311be8f465facdfa5a531b51,
            limb1: 0x5f6ca7f00caaa67b7bac43f2,
            limb2: 0x15e188fe79c5fa7d
        },
        r0a1: u288 {
            limb0: 0x2b7b39c39545706fa1c9610,
            limb1: 0x63160ed90fce6ff534d95c63,
            limb2: 0xc45c6c135f289a2
        },
        r1a0: u288 {
            limb0: 0x34d84d622472b5ee014d6f27,
            limb1: 0x9d7294a6e26a4be46ea0302b,
            limb2: 0x1f2764cbd3bed5d3
        },
        r1a1: u288 {
            limb0: 0xf90621186b776f347f2e71ce,
            limb1: 0xed6d87eec041d45b317af56e,
            limb2: 0x4d0ffe470751b81
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc2ed7a4c2d6751449136ef70,
            limb1: 0x46cc8f6dae9100b075c4361a,
            limb2: 0x2dac877493463610
        },
        r0a1: u288 {
            limb0: 0xd1128e67b11c006955bdaf14,
            limb1: 0x9f1f21f787031b28f6aef244,
            limb2: 0x2f22d15d2537ffa9
        },
        r1a0: u288 {
            limb0: 0x44214fe23ac00e8a5bbb546f,
            limb1: 0xc7093acc721e4120a73fae10,
            limb2: 0x2da2663e67a0f90b
        },
        r1a1: u288 {
            limb0: 0x8635a6fd830a0cf5cb5ef200,
            limb1: 0x29119b7209bf75085688fd4a,
            limb2: 0x215d7210bfa5af58
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4df302adbea0771a649e08a3,
            limb1: 0x2f322e4abf30480e09838278,
            limb2: 0x2206c80eabcf71a5
        },
        r0a1: u288 {
            limb0: 0x7af6d58f1eda6d270e911f11,
            limb1: 0x894540cdc081a32f9f94f4da,
            limb2: 0x1ce35d53ce1ab6d0
        },
        r1a0: u288 {
            limb0: 0x25781be7e38aa95f6fd030c1,
            limb1: 0xcc9124c312fa4c46c1b1690,
            limb2: 0x2e9b8cfff045e6d3
        },
        r1a1: u288 {
            limb0: 0xb580c8aed7e0493e79b5426f,
            limb1: 0x51e3003bc091f3011feebe03,
            limb2: 0x1cd4aac2a73b4c6a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xde7579581bc621b8bc4dca9,
            limb1: 0x89a9e9178ca1e1494247bcef,
            limb2: 0x451368ec4c0ea
        },
        r0a1: u288 {
            limb0: 0x9ac58d7cf1e7e8f9b763ca91,
            limb1: 0x18f386e5493ec2b402370fef,
            limb2: 0x1d0668b621f5954f
        },
        r1a0: u288 {
            limb0: 0xe960a65398dd1d7823cce32d,
            limb1: 0x4f689d21a57474ba5585961c,
            limb2: 0xdc6cf0a6f1c970e
        },
        r1a1: u288 {
            limb0: 0xc434ba1a69461926d2231282,
            limb1: 0xd5cbaf6222d52543a50f9fe1,
            limb2: 0x296966ddf6a5f64c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x66864808398ebcf3a0cd472f,
            limb1: 0xac56f6c401a3290125c9448b,
            limb2: 0x2a07194047ebfa6f
        },
        r0a1: u288 {
            limb0: 0x875ebe3a589593ea4763698a,
            limb1: 0x47c9d871cb5e7307693dcbac,
            limb2: 0x5aedb229039636
        },
        r1a0: u288 {
            limb0: 0x89540a70e7d19ff5dc147c4c,
            limb1: 0x91cdfdbaf5bb1cf4221ab9a7,
            limb2: 0xaffbfc315ed1517
        },
        r1a1: u288 {
            limb0: 0x73fc7f4fc020c311e8f919de,
            limb1: 0x4b15d745482284e67b17a4ed,
            limb2: 0xb956338b16a915f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x97881d379463311ce807227a,
            limb1: 0xde21c1dd3e1f7531ded8435e,
            limb2: 0x5c2db40ebea70c7
        },
        r0a1: u288 {
            limb0: 0xf62ea3e5a665c74b40330ba9,
            limb1: 0xb8cb3a7724ea37e57e405937,
            limb2: 0x7972ff85e35f913
        },
        r1a0: u288 {
            limb0: 0x40b555881214f78bff03ad55,
            limb1: 0x95c476bb359f87bb634e4a7b,
            limb2: 0x2cf1483b0130b081
        },
        r1a1: u288 {
            limb0: 0x6fa208b18d9d86e3ec4b5a8a,
            limb1: 0x3d66569fadf121be5e9da454,
            limb2: 0x1e74c2eaf5b72868
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x67fdfacd5b5f88b98e3508ae,
            limb1: 0x76d95e4fd568a9a13af5ed57,
            limb2: 0x7461ff51be93821
        },
        r0a1: u288 {
            limb0: 0xbe5638aadabe8de69d2854b0,
            limb1: 0xb2c4f1d601010d5551afd3f6,
            limb2: 0x5fcecdd9df11ef4
        },
        r1a0: u288 {
            limb0: 0xee2127e7f5c80c435d704503,
            limb1: 0x90dc15db766bfe7bbdc1eb46,
            limb2: 0x2190b96bcacd558d
        },
        r1a1: u288 {
            limb0: 0x1b49d33636907ad078a34037,
            limb1: 0xd16036827b2d5cade3869fbc,
            limb2: 0x2e464d7860e31aa0
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x82fa67076da373fd58b18fa8,
            limb1: 0xccbf589ac9cfb8859d9cfb65,
            limb2: 0x27dc35547663fa80
        },
        r0a1: u288 {
            limb0: 0xeccb7120bbf6d9af6a87b044,
            limb1: 0x2c82debd2ee9b44ded6e0b39,
            limb2: 0x113211f8fbb3c2d6
        },
        r1a0: u288 {
            limb0: 0x4592c88e8c614119e22153a3,
            limb1: 0x3ac23b96aae81eb66ce1555a,
            limb2: 0xe8e779480ee0ed
        },
        r1a1: u288 {
            limb0: 0x956c57e037683a402b118316,
            limb1: 0x3aae929017d75631b0fac36b,
            limb2: 0x2b24833c0fb084f8
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xdfe52f320a93a1cba6803fcd,
            limb1: 0x5b491dd8569488de86e8a96,
            limb2: 0x15e8839de155f83e
        },
        r0a1: u288 {
            limb0: 0x804d622ef5cea368a9848cb1,
            limb1: 0x1131b7463b5d6e576bcc2ee5,
            limb2: 0x2e1031dbc8228097
        },
        r1a0: u288 {
            limb0: 0xd082c9023acf71a6bd8677f8,
            limb1: 0x4b4537519782d8bd9cd13670,
            limb2: 0x181379ece8e059cc
        },
        r1a1: u288 {
            limb0: 0x48e5b2223aac89e710cc6b31,
            limb1: 0x78e5164b4f57a59c7ccd6cff,
            limb2: 0x184282293a0f5b1a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9c9f86b1901f574515c9fe2d,
            limb1: 0x7e69fe38d71e5cc9b1283ed6,
            limb2: 0xb63f9856f120679
        },
        r0a1: u288 {
            limb0: 0x20665d00ad3a84ace459fea4,
            limb1: 0x25012b9732b68314c66d7b15,
            limb2: 0xc3741e072a562b5
        },
        r1a0: u288 {
            limb0: 0xee548d5db9a80c3f3881c742,
            limb1: 0x90e0ffe137304594c393b5b7,
            limb2: 0x1457c21a723f1111
        },
        r1a1: u288 {
            limb0: 0x41b425176ae72643cce4294a,
            limb1: 0x110a7faf5d879010d505de00,
            limb2: 0x2b0a0f539ffd6621
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2231b5976d842496597b9b6e,
            limb1: 0x7520fd9781e17764f701b39e,
            limb2: 0x1b4509237780fd65
        },
        r0a1: u288 {
            limb0: 0xaeac55878d1c6b7e46e4d725,
            limb1: 0xa04194b0e9995e22fb86e445,
            limb2: 0x16cea6f8a78239dd
        },
        r1a0: u288 {
            limb0: 0xf3b32d4281594a900f1deb3f,
            limb1: 0x72945ccbe181d1a69d7320cb,
            limb2: 0x1c5e405d9baf7394
        },
        r1a1: u288 {
            limb0: 0x1bd235e233495ddf31404ab4,
            limb1: 0x65db1f22c4bda4ac5844da6a,
            limb2: 0x2a271483f7de2b1d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x9c483defea003b7b54d495c2,
            limb1: 0xe012ac657020204101c7c180,
            limb2: 0x29a3f43ec542654c
        },
        r0a1: u288 {
            limb0: 0x5b07d8beebcd73ae1c12c68b,
            limb1: 0xbc96aa144d5e18721ff68419,
            limb2: 0xf0e40c4a186fa69
        },
        r1a0: u288 {
            limb0: 0x3be7245ca03644bc67c090bd,
            limb1: 0x7d1c4f212b638e6f8c124923,
            limb2: 0x21059c01a216e122
        },
        r1a1: u288 {
            limb0: 0xd8e620b393a1e9ad154f84f1,
            limb1: 0x783a67e8cfaa7c6e8b24dc51,
            limb2: 0x4d1df282ccb52a6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6cceecd5429e0e839fa54334,
            limb1: 0xcdcf8eaf710ded2b337ef59,
            limb2: 0x7ecb8c7aee90a3
        },
        r0a1: u288 {
            limb0: 0x31d0de4108673333de7742ea,
            limb1: 0xc81a859162e4ff175a4f9932,
            limb2: 0x2300cf08b32f2888
        },
        r1a0: u288 {
            limb0: 0x394475b672f9e7b3f77d80c3,
            limb1: 0x2f06850a2fdb5af3b949cd65,
            limb2: 0xc180ecb1b9dbcc0
        },
        r1a1: u288 {
            limb0: 0x312b1dd296dd854d4bb1791,
            limb1: 0x3fc146ea5da64853dff37dd4,
            limb2: 0x2965c6668f74ddc3
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2984dfd23d4dbaf77781557a,
            limb1: 0xeb83f82937e2c987a9f8b98c,
            limb2: 0xacabad30beedcae
        },
        r0a1: u288 {
            limb0: 0x755e0cca01712e0c0e9e6635,
            limb1: 0x4d03dd0841f45cc56af94a7,
            limb2: 0x21c2a01c2218e89c
        },
        r1a0: u288 {
            limb0: 0x2671ba3f557724a184735d13,
            limb1: 0x534aba76c12f852a03cc99dd,
            limb2: 0x1740b4b0bce00dfe
        },
        r1a1: u288 {
            limb0: 0x28445d920d4326d6b58644a6,
            limb1: 0x3d7ce8b1cd3efde05f2cfa63,
            limb2: 0x449d332f38073d3
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xac586ec1b3f9b852c344de5d,
            limb1: 0x9e427545e5f5971bde38aeaf,
            limb2: 0x1f3ee084a57ea307
        },
        r0a1: u288 {
            limb0: 0x7b5662b8fa3b75a7d16b6f4,
            limb1: 0xce0ad7878d477789d90c0001,
            limb2: 0x11baddc183961e29
        },
        r1a0: u288 {
            limb0: 0xea9d4e65e236281fabf18729,
            limb1: 0xcdb0dadcda2327232c12bc7d,
            limb2: 0xb7627b78aa8e74f
        },
        r1a1: u288 {
            limb0: 0x5c6bb267bf3b618b087bd91e,
            limb1: 0x5bac6208cc3cdd9b0c28a7b1,
            limb2: 0x6dc31e6832afdc1
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x5659a67581d340e1739bf03b,
            limb1: 0xc0247a20b5099fa1f2576eca,
            limb2: 0x1b62fc5a8853ad51
        },
        r0a1: u288 {
            limb0: 0xc73704292d5f74a9c6b90cee,
            limb1: 0x4b8dc68dc5f8182dbd72f828,
            limb2: 0x182a7b33c41b9b26
        },
        r1a0: u288 {
            limb0: 0xee3b8555091b22b4e7dcb86d,
            limb1: 0x9b825c5c01e51edd92adcc77,
            limb2: 0x999402aa73ee8b8
        },
        r1a1: u288 {
            limb0: 0x36f623405b8cd7520e1a537e,
            limb1: 0x9d3572ee0650e206169c300d,
            limb2: 0xe06a993c9ab0cf9
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc56686aec57e8fc023ecddad,
            limb1: 0xbc9bd42b8b8e8feb70081685,
            limb2: 0x22f6e99c704d136c
        },
        r0a1: u288 {
            limb0: 0xd21088ccc0777817b2137c1,
            limb1: 0xad49e45eb4d16901f52f9bd,
            limb2: 0x171766bfb6cece79
        },
        r1a0: u288 {
            limb0: 0x2394f3bad90330f89d43f09f,
            limb1: 0xca9bf0aa6f34faec6f328453,
            limb2: 0x2aaf0f32b3f322ee
        },
        r1a1: u288 {
            limb0: 0x4716ddfae37f9f338aa82c8c,
            limb1: 0x92003c20d9963f72c77560c2,
            limb2: 0x2c36337f2828a0f6
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xffffcd1a40597c2067620bf2,
            limb1: 0x5455cd0a904b4dea3dafdb12,
            limb2: 0x26f48b4f1acd3c62
        },
        r0a1: u288 {
            limb0: 0xe4007dabdc993e5a7907f5a7,
            limb1: 0x3ab510d60fe22be06c2212da,
            limb2: 0x1b0f8fed80ef5e22
        },
        r1a0: u288 {
            limb0: 0x37560e85b209b3e17372440c,
            limb1: 0xe79fa8f20c065e79c3de7891,
            limb2: 0x1143d5af5bd24a6
        },
        r1a1: u288 {
            limb0: 0xcd0265d5396535eef5d7a798,
            limb1: 0xde5c240436a66fb69907c18,
            limb2: 0x14c295ba4f93edcf
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xbfa5bd30a1f424bbac1f0649,
            limb1: 0x6b6ea73b6f1bb14ce79a68f6,
            limb2: 0x264a70f7fe0fb9ae
        },
        r0a1: u288 {
            limb0: 0x72801235f81159084b33227b,
            limb1: 0x4647df95fb421a450f8822aa,
            limb2: 0xc5ccbb66de1121e
        },
        r1a0: u288 {
            limb0: 0x147eb6c3f8021c1c6f58df12,
            limb1: 0xbcf6c79f22ec9162ab223d16,
            limb2: 0x2f91ca4a62d09f7d
        },
        r1a1: u288 {
            limb0: 0x876273187d9ed75dbadd9be0,
            limb1: 0x85066ad181eb77d2443ec56b,
            limb2: 0x25021d1664a4b350
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf6cb235a3d47f9299ebe216e,
            limb1: 0x852599914f82ddd56f61af96,
            limb2: 0x121d34775b3a65dc
        },
        r0a1: u288 {
            limb0: 0x151348c324b5e643d5ed49f5,
            limb1: 0x72ae1f04a5b1795303ba0c5e,
            limb2: 0x7f8cd466a1966c7
        },
        r1a0: u288 {
            limb0: 0x3fa95300a2634f1e02e24d5,
            limb1: 0xee52618de96c56f4642b13c5,
            limb2: 0x238e2736200f82dd
        },
        r1a1: u288 {
            limb0: 0xf2e368d7468d872f5948c44b,
            limb1: 0xee3fc8e452519ea06891ec1e,
            limb2: 0x29676047585fac64
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7883f5e8ac1f8a541cbd2f2e,
            limb1: 0x19cf57fb53408240d5d92b70,
            limb2: 0x23c0d7bc3e3c3790
        },
        r0a1: u288 {
            limb0: 0x8e0d0c1e8a0384153b07de36,
            limb1: 0x3c81642f59eaddb183b01b7,
            limb2: 0x1c8d4be04bdcf6e3
        },
        r1a0: u288 {
            limb0: 0x4ac5a38093a7340a32d7fd88,
            limb1: 0x5235ba1dc9c819c1ab0ff106,
            limb2: 0x257265efa46e4758
        },
        r1a1: u288 {
            limb0: 0x567a7e5027d09f5c260a596a,
            limb1: 0x8e2ebcf42594b004d198335e,
            limb2: 0x1f3f1e0296bc842d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x2971703bf3794c1c2a2f37ef,
            limb1: 0xf5c4fcd064981dbab08c3d18,
            limb2: 0x1926258fbe0e9cf6
        },
        r0a1: u288 {
            limb0: 0xca4474715183952165dd6e7a,
            limb1: 0xa41725e0bc1d6e2b24b6b91a,
            limb2: 0x32332ba135d8a22
        },
        r1a0: u288 {
            limb0: 0xcdd07d53d597a3ed94cc3d59,
            limb1: 0xf2c2b26492c77f102d01f7b4,
            limb2: 0x29c4d23c184ea751
        },
        r1a1: u288 {
            limb0: 0xb9b3c8ce6c0d6577b9f8f013,
            limb1: 0xbc3c9df3a35d624988d65ebd,
            limb2: 0xfc69cea6b487463
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe5877d3c9d981f66ed35c11a,
            limb1: 0x164df992a49a9f54ccb35826,
            limb2: 0x201e6d58220f348f
        },
        r0a1: u288 {
            limb0: 0x80a204d406b9bda131eeed61,
            limb1: 0x82e81103b4964321cf8f354f,
            limb2: 0x60e88c3df8192dd
        },
        r1a0: u288 {
            limb0: 0xe1c2d7c4fef9fb7d9ae8ef15,
            limb1: 0x41e953cbd961f5eb2ce6e31b,
            limb2: 0x24e237a7c89bcad8
        },
        r1a1: u288 {
            limb0: 0x500636c34d387f2d628ed21f,
            limb1: 0x5d98e206b785fd5cf7d187fe,
            limb2: 0x1968d15eb8e11053
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfcb84f1a0ac4d4acb7db98b3,
            limb1: 0x309f286d1ec3a9c0bea64819,
            limb2: 0x19da4f925bf6e733
        },
        r0a1: u288 {
            limb0: 0xd3319fcfac2c7ba875ff35ba,
            limb1: 0x9769a9c9e4f8291aa0720f9a,
            limb2: 0x142f5d59dc1c4a76
        },
        r1a0: u288 {
            limb0: 0xf411d1ae3ea0aab19ce98c8,
            limb1: 0xac26b14e81641ded93c6f136,
            limb2: 0x7760c1919ccbe11
        },
        r1a1: u288 {
            limb0: 0xd7506df93f00965a726e083e,
            limb1: 0x65f687f2163a5a87a5e0d19c,
            limb2: 0x9315d931a30437d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x5d31804411c4631e17787d33,
            limb1: 0xbf99b7cba90d85895946ed17,
            limb2: 0x1a11df76f290610a
        },
        r0a1: u288 {
            limb0: 0x1155107689b476ef3bf57477,
            limb1: 0xf1c1d73bdb8729af24bf09df,
            limb2: 0x1a15e0fa5d487d34
        },
        r1a0: u288 {
            limb0: 0x8f0241ba4333d2287807876f,
            limb1: 0x157e0f2b63c3fb1f59ea5d1d,
            limb2: 0x2fe15b080fb90739
        },
        r1a1: u288 {
            limb0: 0xab627e4e0cd42f18b068d39,
            limb1: 0xda5c50f72102d7fbcaf26967,
            limb2: 0x27beb5f0ad2a58fb
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7a583bc8ca602f78eb261487,
            limb1: 0x962e7819ce32f83730ca20ab,
            limb2: 0x28cf6b476bdd9d9c
        },
        r0a1: u288 {
            limb0: 0xa63b2614af3428fbaa0bf9b4,
            limb1: 0x183cfbcc197406585ed01f25,
            limb2: 0x2aeabe1d64745620
        },
        r1a0: u288 {
            limb0: 0xadbb289fc83bb68697b9485c,
            limb1: 0x74f0fbf9170ba09203fd114d,
            limb2: 0x1b7f101316554e45
        },
        r1a1: u288 {
            limb0: 0xefe1cc866ed48612f9f70320,
            limb1: 0x733aae0d21dbbfffda333085,
            limb2: 0x24099f5bf58b8714
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf79c17529a8cc6a972ff3f75,
            limb1: 0x8af36bd59955ca5b8abb3296,
            limb2: 0x16d19346bf4cc73c
        },
        r0a1: u288 {
            limb0: 0xac7c80aba8ee98ad9bfeec38,
            limb1: 0x30c70463f0a350811296dc93,
            limb2: 0x1c30ef4ed69e7ca8
        },
        r1a0: u288 {
            limb0: 0x1e66adc4df801665b0747840,
            limb1: 0x19b1156d92ff41006d30bf3f,
            limb2: 0x1fb0467461668c2e
        },
        r1a1: u288 {
            limb0: 0x74f6646fedacc594d553ab7c,
            limb1: 0x718a878695d3ef60677461fe,
            limb2: 0x1712154eb685c8e0
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x7a45f8edda26b14320cd488d,
            limb1: 0xbe26ec9694cb49beeb13aaac,
            limb2: 0x774cabab5924c96
        },
        r0a1: u288 {
            limb0: 0x448a97eae9f4d0b461bf0651,
            limb1: 0xe0efc1adea7cc6c028e2efb6,
            limb2: 0x2372a05cbd98ff0d
        },
        r1a0: u288 {
            limb0: 0x1887b9ffad3d0f5656cb8885,
            limb1: 0xfe506a4bf7368876599a0b08,
            limb2: 0x8a53c31e30402ff
        },
        r1a1: u288 {
            limb0: 0xa87a76831936516b02772115,
            limb1: 0xd8e13caf6452a277aeb4c08f,
            limb2: 0x2731c1ab4621ff5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf712d859fddd5168d9f8ba2e,
            limb1: 0xb1b667ac60f1e12146b13cd1,
            limb2: 0x2fa001ba24bffbdf
        },
        r0a1: u288 {
            limb0: 0x5ac420f7ede11fbc611ca33f,
            limb1: 0x47aecfe1d715d40047875cdb,
            limb2: 0x2e11911cb128d45d
        },
        r1a0: u288 {
            limb0: 0x757161193d459606b0486ec5,
            limb1: 0xf4ef5bedcd05c8bc9217d741,
            limb2: 0x15a443953e33a01
        },
        r1a1: u288 {
            limb0: 0x26b6a0bffcf943148f950f0,
            limb1: 0x42a4b5672131b73c31556f03,
            limb2: 0x53289b49f7934ea
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc996dc26982b700733865f9e,
            limb1: 0x6ca2246dea06b1587b058022,
            limb2: 0x22d9f00fe80a7860
        },
        r0a1: u288 {
            limb0: 0x91b8c6d4eb55200c86aa40ff,
            limb1: 0xb28a86133e89d35bdb4f0eb3,
            limb2: 0xf5f29a79eb525c3
        },
        r1a0: u288 {
            limb0: 0xb1f53d9ed4300e95d688952d,
            limb1: 0x48850616c93537782887508f,
            limb2: 0x2f85cdc4893e8f8
        },
        r1a1: u288 {
            limb0: 0xa6a6b7bbcf0f68fa3fb69e48,
            limb1: 0x7fa042ff9c3321ed1d2491c0,
            limb2: 0x214dcb7e951effa0
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x8465f2f3d276114fe36a34b5,
            limb1: 0x38ff9a2804d559ab27359ef5,
            limb2: 0x69dcefb5e7c45e5
        },
        r0a1: u288 {
            limb0: 0x374c72f7d2a7f2cc4e6c485c,
            limb1: 0xb7075105aba375ab267e7a68,
            limb2: 0x8e0be8b4ce9b4
        },
        r1a0: u288 {
            limb0: 0x96d4fac89b1c2be5d26ec569,
            limb1: 0x39db3a0e3121cbb1abadde74,
            limb2: 0xaccb5cc1cc9025e
        },
        r1a1: u288 {
            limb0: 0xe934612947673c898cf0f1b5,
            limb1: 0x66fedc8ac335e0035d99b51f,
            limb2: 0x1103bfbe6ea25fee
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xfe4c6efc4d8718316c452d4,
            limb1: 0x9d0f66ef4917eb2f9f281df9,
            limb2: 0x223981cb3cd86cb1
        },
        r0a1: u288 {
            limb0: 0x7d9db7b1a69c64706e58718d,
            limb1: 0xf8cf32491e46edcfb84c398,
            limb2: 0x1872385e64ccfd8f
        },
        r1a0: u288 {
            limb0: 0x4c9847220371773576a16d4f,
            limb1: 0xa3f212548dfdfec08052ec50,
            limb2: 0x2f3e2a713849782a
        },
        r1a1: u288 {
            limb0: 0x425808e4606667792ed46327,
            limb1: 0x97826fc03a7717e11167baaa,
            limb2: 0x15baba95a7fa7017
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe82691e8e2b89cf4c5b9d182,
            limb1: 0xf0ab958acea8a0fb2c1e3334,
            limb2: 0xf99cc3c7ed6245b
        },
        r0a1: u288 {
            limb0: 0xe6ac630038c32e0737dfa2c,
            limb1: 0x68e037b5de0d580a59e418ef,
            limb2: 0x205f57077b90a614
        },
        r1a0: u288 {
            limb0: 0x11d5d90eae07221990516739,
            limb1: 0x8103017bf226e15bc06c6b80,
            limb2: 0x310070a9702cc
        },
        r1a1: u288 {
            limb0: 0xa96a376f5b8338a4dcc6012f,
            limb1: 0xf8cf0e97c909058b7108033c,
            limb2: 0x55e1b09c3657d77
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcd5c349e45361a5e48852c4a,
            limb1: 0x81a89eb6a92c918a297d08a2,
            limb2: 0xa41a01012f71b86
        },
        r0a1: u288 {
            limb0: 0x232269e063936df4779b3fb4,
            limb1: 0x2a1eaa3037afa54f3a6f89ae,
            limb2: 0x2409a1998480ca9e
        },
        r1a0: u288 {
            limb0: 0x29c21bf55d6059e688b99fcc,
            limb1: 0x263ba8dee0495950111fe61f,
            limb2: 0x17d4b189704a73d5
        },
        r1a1: u288 {
            limb0: 0x503cff9f3f63f3c27ee13142,
            limb1: 0x27c8973d5ccfdae38a6ffbfa,
            limb2: 0x8bc14b771c82927
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xd339572516ec14bc4735fe25,
            limb1: 0xb97f65c651890fb92070615c,
            limb2: 0x2bdfe3626c6b617e
        },
        r0a1: u288 {
            limb0: 0x498061c89d8f860e5a9ef248,
            limb1: 0xf9241b3cd1a9e16ba5c2c125,
            limb2: 0x20712212a0fc0481
        },
        r1a0: u288 {
            limb0: 0x1dd290ad35b4f04f5d867241,
            limb1: 0xe43f2e6f93d449da6c890398,
            limb2: 0x2b50b4601b17e466
        },
        r1a1: u288 {
            limb0: 0x97a970f2f249006d9f3837d1,
            limb1: 0xf259a3b032c89f62a25dd28f,
            limb2: 0x9afa1f07487394e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x3c2c709eb4fc2184a6900320,
            limb1: 0xb557ad265924c9a081dfa3ff,
            limb2: 0x153f088e3ce5d9d3
        },
        r0a1: u288 {
            limb0: 0x2b13a4d2aeba73037256513e,
            limb1: 0xa293bcb6445d0cbefaa997dd,
            limb2: 0xa1290e5687bf375
        },
        r1a0: u288 {
            limb0: 0x8aa19521ed3b0b3834c88601,
            limb1: 0x6b78d1ebe1cc43a6ddbeff8,
            limb2: 0x2a2a03ba0f0af082
        },
        r1a1: u288 {
            limb0: 0x388b78df20c87f62d167a7fd,
            limb1: 0x2bc34ea2677653e233dea2fe,
            limb2: 0x849ecbc55d91824
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x37f9d9151339e47312b14c90,
            limb1: 0x48da6d9d682f1b6e4116fd19,
            limb2: 0x1a9964ac6ba92caa
        },
        r0a1: u288 {
            limb0: 0xe80947d651d0d81bb700a072,
            limb1: 0x6d0a553728120c240312bfc0,
            limb2: 0x4f86cc1c14da656
        },
        r1a0: u288 {
            limb0: 0x715530318c48e3c61b469ac0,
            limb1: 0xaf62e0788d796100b3e53e71,
            limb2: 0x2b297374622e6b6a
        },
        r1a1: u288 {
            limb0: 0x1071d9380dfda6e028d432d7,
            limb1: 0x5ffacc0ffbd9ceb33bafb36f,
            limb2: 0x28ac800165cda8c5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf11b041858555b52ba410910,
            limb1: 0x3dceee36e0b017320f1c5413,
            limb2: 0x1ea5ef11dfadac27
        },
        r0a1: u288 {
            limb0: 0xd08a324cdf088c4752df1041,
            limb1: 0x1bab2ee8e83854accd6f8924,
            limb2: 0x192edbd4042f4982
        },
        r1a0: u288 {
            limb0: 0xcd423d6684c0ee32e29051d4,
            limb1: 0xf3f343d8b2b3e59019ca47da,
            limb2: 0x2ae2039390de91d9
        },
        r1a1: u288 {
            limb0: 0x9069b3948680c77cd677278,
            limb1: 0x80054ec27d6457c94d51f594,
            limb2: 0x27f9b4ea514069a5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa1a6ff6d2b4b7bfa0f66855a,
            limb1: 0x736b220777598d1921e92be9,
            limb2: 0x24ddeb7e12c7b6fc
        },
        r0a1: u288 {
            limb0: 0xcda15d71321b44bb14b51dd5,
            limb1: 0x28edcce6efcf91b406bc7f17,
            limb2: 0x24aef25f44079b61
        },
        r1a0: u288 {
            limb0: 0xbdc456e62bcc2b1a3654eb35,
            limb1: 0x50689985bc2a1afaefabdc7,
            limb2: 0xf9101d479bba69d
        },
        r1a1: u288 {
            limb0: 0x1e850588662ca5bb05282afb,
            limb1: 0x4f1734483f5e81b2db2cd306,
            limb2: 0x2191787fca23a6a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xabc5274bd64f02a76191040d,
            limb1: 0xff38877facdc6384351abee4,
            limb2: 0x90a847f43c829d6
        },
        r0a1: u288 {
            limb0: 0x885fd5faf819530f2b38cba4,
            limb1: 0x55ffd38381f6e0aff1803687,
            limb2: 0x5fb852a401e1fb
        },
        r1a0: u288 {
            limb0: 0x9909c4ce0e16b2fd35d3f6f,
            limb1: 0xbc287a98297b33cbb8e8c465,
            limb2: 0x1db3690545e211c6
        },
        r1a1: u288 {
            limb0: 0x983d058f775ccdf761db1c6f,
            limb1: 0xec83c31c92c3abb7759a782c,
            limb2: 0x2f12016a437cbb4e
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x35de2b6217eff61166b3dc6a,
            limb1: 0x4e923d035fdecff168b0ffb5,
            limb2: 0x1648a81efc6bba68
        },
        r0a1: u288 {
            limb0: 0x5f772eafb49dd4c47e51427c,
            limb1: 0xb0a146ce6e6cbdf714216ba,
            limb2: 0x19e4f05c09669aa5
        },
        r1a0: u288 {
            limb0: 0x424c24ab27d4c3158b820d7e,
            limb1: 0xc50d6d29dba5e8ca5f03283f,
            limb2: 0x1839809f6c7d0e3
        },
        r1a1: u288 {
            limb0: 0xe16db0b3dbf4c84d1981827a,
            limb1: 0x17e5b39e426af56a3878e2f3,
            limb2: 0x26483437f8136454
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x42f2953e4245550050bdff43,
            limb1: 0x3eaacc2bee374f3a7fa4fb38,
            limb2: 0x1077bd505f194b24
        },
        r0a1: u288 {
            limb0: 0xb0a6dc54961d61068643c034,
            limb1: 0xac3ce6aaf1b6a7c5b0846600,
            limb2: 0x1e5520f2f0324c20
        },
        r1a0: u288 {
            limb0: 0xfd5b5530e2a74037c88d6b6e,
            limb1: 0x8da3ce4a7328db6592b0d670,
            limb2: 0x20f31a694341a0e
        },
        r1a1: u288 {
            limb0: 0xa8aae3eae8c7e2a610e79b65,
            limb1: 0xcfd2a56ee8aee171527bb984,
            limb2: 0xfb3c9e4f76781bc
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe068846a8c313f87cfbba0f9,
            limb1: 0x1b942454343875305df5d69,
            limb2: 0x1513cc595dd05401
        },
        r0a1: u288 {
            limb0: 0x759b1aab6de04bf9ce997cf8,
            limb1: 0x4472c9f97f6a81cd98c0a383,
            limb2: 0x197abe0a0b428ebc
        },
        r1a0: u288 {
            limb0: 0xa953899e6e5854ac73f932c9,
            limb1: 0xc4612407530d7d7000676b98,
            limb2: 0x227faac01d313470
        },
        r1a1: u288 {
            limb0: 0x26bf90f289565f56449ade22,
            limb1: 0xddff6bd70906211451249be9,
            limb2: 0x759b419af9ba040
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xaa6b1f461d2392087c69fb4d,
            limb1: 0x65a304436d6b2a870de6c09a,
            limb2: 0x164b65d66700f01b
        },
        r0a1: u288 {
            limb0: 0xb41c8088975fd4bcfebd9d7e,
            limb1: 0x3330c9ff28d503d242281ccb,
            limb2: 0x2a227ed9eed35b49
        },
        r1a0: u288 {
            limb0: 0xbffc49efaadc78ecb440eaf0,
            limb1: 0x55f64604693d0ba8bbc06b3d,
            limb2: 0x300f5cd82a935df5
        },
        r1a1: u288 {
            limb0: 0x1d0d95fa599a9d33c5d7d270,
            limb1: 0x30dd0ca2cedfbcfe8d8ed843,
            limb2: 0x1325bdd87c346161
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1268bc13163032843898bfc3,
            limb1: 0x25b17aa10882829f5ab8da3d,
            limb2: 0xd65f1263c5596f
        },
        r0a1: u288 {
            limb0: 0x8f60af18a94cf1d302acb2fd,
            limb1: 0x608a008d15ff01c04d99aee,
            limb2: 0xb93c64adade968
        },
        r1a0: u288 {
            limb0: 0x7d30931b7cdfce26f70d9cd8,
            limb1: 0xe91734f2f5dcbcb9c70fa421,
            limb2: 0x17a98f352272d53c
        },
        r1a1: u288 {
            limb0: 0xafb2b1561a37c8a8801e9adf,
            limb1: 0x70148600b3005dc7dd1c271c,
            limb2: 0xeda651acd4636e5
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x70d2f88dd5588e96cd3cf6ac,
            limb1: 0x3474c742c160031837a85f7c,
            limb2: 0x12f86ffd643fcd17
        },
        r0a1: u288 {
            limb0: 0x40ad908bb024a79ac19cffe5,
            limb1: 0xe17a5b6c1f623ba4de2534f6,
            limb2: 0x1b040a617a261596
        },
        r1a0: u288 {
            limb0: 0xf7d36be6c3cb18b8e650eab3,
            limb1: 0x475d2658e87ad02ecd40ca87,
            limb2: 0x19e8c8347f7d2909
        },
        r1a1: u288 {
            limb0: 0x889faef0a0ba18661cc99bdd,
            limb1: 0xd84f5f6ef2cb8b52a6df594,
            limb2: 0x9a3313cde6f3d0c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x948b72a514600060c28be567,
            limb1: 0xa12dcf4046bdce4ab929460,
            limb2: 0x2b5849579b28f76d
        },
        r0a1: u288 {
            limb0: 0x3feb6558ca24b678ac9dbc61,
            limb1: 0x191307fba9338dd8e8c86f84,
            limb2: 0xcaad00c0b46a2f8
        },
        r1a0: u288 {
            limb0: 0x4a0472ffa26914741dc600c4,
            limb1: 0x851d078eb8a2fb588a2c52bc,
            limb2: 0x2716cd84cfde6e6c
        },
        r1a1: u288 {
            limb0: 0xe654ece90c6de4f1f96a727c,
            limb1: 0x48e5a70992c84e1a053d0331,
            limb2: 0x23201db153114c0f
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x773514333016affc0c6119ab,
            limb1: 0x67dbd0a387685644a1e5720e,
            limb2: 0x1b68689b5992450b
        },
        r0a1: u288 {
            limb0: 0xd66bf15f0c376b45b73ed2d3,
            limb1: 0xc64656720440664834ef49ce,
            limb2: 0x13e56e7f14633662
        },
        r1a0: u288 {
            limb0: 0x2e333b07fd42ced2f7603f07,
            limb1: 0x77ac115ae769ee24db9de16a,
            limb2: 0x1cb11bc485183fea
        },
        r1a1: u288 {
            limb0: 0x432df8b2466bc177aa3e1869,
            limb1: 0x4f1027ce7bf5c020f2df5d63,
            limb2: 0x172c0d0909c7396c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x1db7791d06e489df1d1959b4,
            limb1: 0xa5de73200b3444866b28f3f6,
            limb2: 0x2eacf3e4655f8e1c
        },
        r0a1: u288 {
            limb0: 0xd9cbd0aa15cc2a10d0935f6b,
            limb1: 0x5efc1a974c731e3442de0341,
            limb2: 0x2093631a5c94ae02
        },
        r1a0: u288 {
            limb0: 0x468a78850bf8c189b2e8e8bd,
            limb1: 0x68c05a23d1b770249f88803d,
            limb2: 0x15c4e536ad75bdf6
        },
        r1a1: u288 {
            limb0: 0x2f4233ca633ce2a13d13c0ad,
            limb1: 0x48b7824267b5901c017cc1f5,
            limb2: 0x14ac11675a012348
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb86033584849f6c968ae85bd,
            limb1: 0x6fb9c4ee1e9996f5e254b89f,
            limb2: 0x184686807504af9c
        },
        r0a1: u288 {
            limb0: 0x7d5a8c7b3094409f49bb6f7c,
            limb1: 0x36ffc4e9aaef14e88b12200,
            limb2: 0x131756d58975afa0
        },
        r1a0: u288 {
            limb0: 0xfd9a620152f6aa86274488dc,
            limb1: 0x162298a06a9b399f81be0b3a,
            limb2: 0x200016ff0e0aded8
        },
        r1a1: u288 {
            limb0: 0xe96f3f2a92841f909eec1175,
            limb1: 0xa82b6f19e73370e4f5a350f6,
            limb2: 0x14e7f85c89734d7
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x706eed511e95691603760dcf,
            limb1: 0xd7aecb24e912a5db093d54a4,
            limb2: 0x2e2247753bcd7c3
        },
        r0a1: u288 {
            limb0: 0xf3831fcd85a3f110b0b0da8c,
            limb1: 0x4c0453df337005ff1c8766af,
            limb2: 0x29053c0fc65713e2
        },
        r1a0: u288 {
            limb0: 0x3b419aec3b65005b72d887e2,
            limb1: 0x9de9a0e80133fec3843c4a7,
            limb2: 0x20887ef9fc9d4ff2
        },
        r1a1: u288 {
            limb0: 0x908cbde0cbc98b9d09880343,
            limb1: 0x38fc2b1cd6e237e77364f65d,
            limb2: 0x17c19daa537e477
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4e0bd2bd3a8539f1a7f2980,
            limb1: 0xc6dadfd11d5200bcf0c1f82,
            limb2: 0xb6824158e065545
        },
        r0a1: u288 {
            limb0: 0x1d08a3040a5ed9079cad6f6d,
            limb1: 0xe1024824122ee9983b4ea85,
            limb2: 0x2fd239169e06b63d
        },
        r1a0: u288 {
            limb0: 0xef04e3e12f63dfdffaf724f0,
            limb1: 0x821ad0266381c8e6e5a049b7,
            limb2: 0x1b1db1ae8e551389
        },
        r1a1: u288 {
            limb0: 0x9a44d354d77eac5d90babb6f,
            limb1: 0x5fb163ea95cd42f325346aab,
            limb2: 0x22c91a40596a8e6a
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6744822383c81435e0aba325,
            limb1: 0xe52b955b1ee678d5e912fe99,
            limb2: 0x13865d1a2c03d176
        },
        r0a1: u288 {
            limb0: 0x53b1dde745242045e7c04d19,
            limb1: 0x7254981d161a72e97494c057,
            limb2: 0x2744ca60f3cd77f9
        },
        r1a0: u288 {
            limb0: 0xabe1a59b8d0a67653a67c363,
            limb1: 0xf3fa0ace99bb331151ab6d27,
            limb2: 0x29a5ea5f6e80c10b
        },
        r1a1: u288 {
            limb0: 0x63d0cd517400bc85f35eed7f,
            limb1: 0x63ff70666683cf4a0a365a3e,
            limb2: 0x3f38cad0cac5853
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xa18a617c29c49f350bdf063e,
            limb1: 0xb82ccafc497210163c1f1b4f,
            limb2: 0x64c6ea7c7e92f1c
        },
        r0a1: u288 {
            limb0: 0xfc31eb2d994f6d94004dea76,
            limb1: 0xeea0faefd0c2c8f456247e91,
            limb2: 0x12a67d81b51a0395
        },
        r1a0: u288 {
            limb0: 0x83531e4f23db283dc3174ea6,
            limb1: 0x91e7f6ded941e6de52ca47c6,
            limb2: 0x1b40baf07e069e38
        },
        r1a1: u288 {
            limb0: 0x261fef36ee2cff4f795f9db2,
            limb1: 0x53037c5a4116ec0eccdacb4b,
            limb2: 0x1bc677d660ce0e94
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x99ea88a861984695428e5136,
            limb1: 0x4667b6c0091f6d25052950b,
            limb2: 0x1a30661da37a36b
        },
        r0a1: u288 {
            limb0: 0xa468429b203cd3a228cb48a7,
            limb1: 0x972bbeaf069b0c790770f62e,
            limb2: 0x2cde90171cac8c03
        },
        r1a0: u288 {
            limb0: 0x1bccc05ed0d0ae5ab9d3e3be,
            limb1: 0x530ee067087dde9a16f9312,
            limb2: 0x1648bbb4542f916
        },
        r1a1: u288 {
            limb0: 0xb6b0dbeddda144cceadd0ee5,
            limb1: 0xb76b1d6bada8f3b2282a6113,
            limb2: 0x2fdbc7ef41e467cd
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc6b135a3c26ef275abff46c7,
            limb1: 0x63f5a7c1cebd17b0089409d3,
            limb2: 0x184610c5619d2d95
        },
        r0a1: u288 {
            limb0: 0xfe401ff136a3465b9a45193f,
            limb1: 0x81f88a815fbc51de3b2810b9,
            limb2: 0x38b648270e84d30
        },
        r1a0: u288 {
            limb0: 0xe07c2a8050b6332fcab644fb,
            limb1: 0x988a8adcbde51b1536445a45,
            limb2: 0x9bd01953ebe1c11
        },
        r1a1: u288 {
            limb0: 0xd35ae88eed7f53bca0830de9,
            limb1: 0xbd673d72232baad52dbfd009,
            limb2: 0x144ca356212356be
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xb3a546437988fdf8338d8388,
            limb1: 0x6be668b844ceb0b51b54c69d,
            limb2: 0x1b86e13dfcea599b
        },
        r0a1: u288 {
            limb0: 0x7aaa5f884114847d999cd716,
            limb1: 0x18f1389a0dce769f251290b9,
            limb2: 0x140ac9a2a30d9c33
        },
        r1a0: u288 {
            limb0: 0x3fe8e026ba4f3f4cf5e2b90a,
            limb1: 0xda4a552d58cdabf28bcabbd1,
            limb2: 0xebda1addc6b5ff8
        },
        r1a1: u288 {
            limb0: 0x6981682af4e923c7d35e65e5,
            limb1: 0x36bbb56a5f2cb6cc2994b5a3,
            limb2: 0xc6386930e52563d
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xf169524683a4f58d23f6d663,
            limb1: 0x2bd8c084a43cbccb0982614f,
            limb2: 0x11e50e1e848281e9
        },
        r0a1: u288 {
            limb0: 0x938bcbe09c8159c407c35b1a,
            limb1: 0xb875e2c36347793c07b78bf5,
            limb2: 0x2e297e5ef561cebd
        },
        r1a0: u288 {
            limb0: 0x94df632e7686c67cf7fac330,
            limb1: 0x3e810a52f38d4b43be75aa0e,
            limb2: 0x1911fff430e13c5c
        },
        r1a1: u288 {
            limb0: 0x108405ad66ff7e42433319b8,
            limb1: 0xbd67b81ce213c56e235dee0e,
            limb2: 0x1de26b22ae713cab
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xcd19feb09c6af1c96a2ab614,
            limb1: 0x9d59882e7b01ef9684bbd6e2,
            limb2: 0xa13922c83df571e
        },
        r0a1: u288 {
            limb0: 0xce291864114a438ee7f219dd,
            limb1: 0x89948a3c460316e33b3b2e5c,
            limb2: 0x40ee4ee91cd11d8
        },
        r1a0: u288 {
            limb0: 0xcebcfca426fa86bc660a29f7,
            limb1: 0x600204d0cc18f9bfd255eae5,
            limb2: 0x20175e45c5b45fa0
        },
        r1a1: u288 {
            limb0: 0x703c3c9ae77b80dee7c46f84,
            limb1: 0xc85d943e7e602dc0e8d15b00,
            limb2: 0x1386312eeda9cbe0
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x8171fbd3e2ad694c4a0047ae,
            limb1: 0xb85b9efd2c0b62b914c87fac,
            limb2: 0x158c6c6f0f7c8fc1
        },
        r0a1: u288 {
            limb0: 0xac8743dcc3da988ce6b11b30,
            limb1: 0xb01bd7298d6d690e250b762f,
            limb2: 0x82f03886eb6b0d0
        },
        r1a0: u288 {
            limb0: 0xa1529b5d7536ee27071218ff,
            limb1: 0x66b90525f036b7b44c3cf538,
            limb2: 0x1623d90ca74aa2f8
        },
        r1a1: u288 {
            limb0: 0x94cb832a9c236f17366bfa35,
            limb1: 0x701d5bf528cc820fa37bd77e,
            limb2: 0x1bf906a96b112fb4
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x414a25851648d3d7a387e415,
            limb1: 0xfae8533c0e11bdc19ec707e4,
            limb2: 0x2eb1c56438df3ad9
        },
        r0a1: u288 {
            limb0: 0x140d7b108f5f8f6edc6185c0,
            limb1: 0x22fc03727008f5d3df747c80,
            limb2: 0xb55d0a41fb7283
        },
        r1a0: u288 {
            limb0: 0xda1fce1477e1a7935021e4a0,
            limb1: 0xea38ef5c0c0ec5b340711e9e,
            limb2: 0x769ce4712be46b3
        },
        r1a1: u288 {
            limb0: 0xfcbcda1af26fd8c685a7f04a,
            limb1: 0x2b1bdd85293eddaffa5698c7,
            limb2: 0x1be4cce98fdb0b57
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xc835ac599a70a2b7c5c0bb85,
            limb1: 0x3e51cd6f540c3b7b8a0449fc,
            limb2: 0x2f0ff62642de16f0
        },
        r0a1: u288 {
            limb0: 0x33eb1640470d26556874139e,
            limb1: 0x9d4f171aad09bb33668fb2e3,
            limb2: 0x2df95c9090eeb0a9
        },
        r1a0: u288 {
            limb0: 0x7321e3dc66eb7f297b82297f,
            limb1: 0xb63e20571f71e37b8cee85c2,
            limb2: 0x14d6865e18dbad0f
        },
        r1a1: u288 {
            limb0: 0x21ae2f89b870b7b1bd47fa,
            limb1: 0x92f0979c028da4b1542c2dc3,
            limb2: 0x2f3d577e73d276da
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0xe68fe88314edbbb43e3519ee,
            limb1: 0x5e655c77330e9aa8992817e,
            limb2: 0x193b38ee9a410c62
        },
        r0a1: u288 {
            limb0: 0x6fa839c7b16e237fb23b77a5,
            limb1: 0x3983a5cc44c0b92b585eb2d8,
            limb2: 0x1873d52a1d550e86
        },
        r1a0: u288 {
            limb0: 0xa8011355f684a62eed6463ec,
            limb1: 0x543d6b3d9470a043058b2be9,
            limb2: 0xb0568f05b011d16
        },
        r1a1: u288 {
            limb0: 0xf945d2c74ac9ff40803b623d,
            limb1: 0x39c011d10681221109aa081e,
            limb2: 0x2ef4fb485254c5b2
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x817824bc62c097c6faaa802d,
            limb1: 0x37d797f06793f149cd35d40c,
            limb2: 0x175469f20b47dfe5
        },
        r0a1: u288 {
            limb0: 0xda1953bb1779421caa39719d,
            limb1: 0x4d6559bc149ec37ff403411e,
            limb2: 0x24831d96062a5e34
        },
        r1a0: u288 {
            limb0: 0xcb797c26eaa06963d28173f3,
            limb1: 0x4adb4525e22b301b111ccca2,
            limb2: 0x157edc9c350ae407
        },
        r1a1: u288 {
            limb0: 0x957cb74419babe897437be1d,
            limb1: 0x444f24ad56cbfbbab77038b,
            limb2: 0x11fb32ec82d2dc82
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x6776905e53d72dcef15deed1,
            limb1: 0xc406192daeafedc418ddd0f5,
            limb2: 0xe676dd935d8097e
        },
        r0a1: u288 {
            limb0: 0x77b3aa05fe6309b2214bf4c4,
            limb1: 0x9c4273f9ab7aaf6593e30e87,
            limb2: 0x23e8c513eed4537b
        },
        r1a0: u288 {
            limb0: 0xcf95faa5d06cbf29d812ea9e,
            limb1: 0x7415dffce8b9d45f465f533,
            limb2: 0x1e46c93ad3c310cb
        },
        r1a1: u288 {
            limb0: 0x617600572cf856edd42085a9,
            limb1: 0x6729ed2691bd54e37492690a,
            limb2: 0x2efe3112e56c20cf
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x351734b1219bb0c4994fc153,
            limb1: 0xab2da3f4456278f7c1656cfb,
            limb2: 0x28b7b3c4f8a8e7c4
        },
        r0a1: u288 {
            limb0: 0x16d151afb192017ec91e9672,
            limb1: 0x6e71b5e992b18ca0a7cd75d7,
            limb2: 0x1fb6b42aaf9374a8
        },
        r1a0: u288 {
            limb0: 0xbed439373324fd9d39e553c7,
            limb1: 0x838ee87fa314a05ea621fd0c,
            limb2: 0x13e4f4e804c6feb0
        },
        r1a1: u288 {
            limb0: 0x477be676b7131c1f010d66f9,
            limb1: 0x1c2b6d88a31e458a1b0f8a8,
            limb2: 0xc623dfd6b1d3dfa
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x4a7d0c6a76d3033cd1aa65d5,
            limb1: 0x2009e063c94a6f649cfd2185,
            limb2: 0x2dee0c7a6a5ea96c
        },
        r0a1: u288 {
            limb0: 0x85f6817765300eed61375204,
            limb1: 0x1c2cff1ea16fcadcb5e0ecc6,
            limb2: 0x6c03d101a0836ff
        },
        r1a0: u288 {
            limb0: 0x63d8c445134e62f10ca23d9e,
            limb1: 0xd310d59f4194613f508b16cd,
            limb2: 0xd9c9944e3616c5
        },
        r1a1: u288 {
            limb0: 0x566bdfd7a01ccde49eb9abbd,
            limb1: 0x37d667254c1b38c6d2ef17b,
            limb2: 0x130f1e0bd48ed76c
        }
    },
    G2Line {
        r0a0: u288 {
            limb0: 0x77bd519667aaef6f75a70378,
            limb1: 0xdd6c387d44075755d6690d6c,
            limb2: 0x17a68585a267da1a
        },
        r0a1: u288 {
            limb0: 0x3c81c12a39b28215ac878c62,
            limb1: 0xdb52f311ce39da243c0f5019,
            limb2: 0x131d4d49243444a
        },
        r1a0: u288 {
            limb0: 0x989fa7a202529c2dc6f18f95,
            limb1: 0xf86f3015c7155729a29f6506,
            limb2: 0x1aaca3f752e5578a
        },
        r1a1: u288 {
            limb0: 0xfa129ac3a805475c0386463c,
            limb1: 0x49295fa7f7654df3b94cc4b3,
            limb2: 0x2c897175ba5bb2e8
        }
    },
];


// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.26;
// import {Properties} from "test/invariant/properties/Properties.sol";

// contract Test is Properties {
//     // forge test --match-test test_invariant_principalCannotBeTeacher_0 -vvv 

//     // function test_invariant_principalCannotBeTeacher_0() public {
    
//     // vm.roll(15168);
//     // vm.warp(550225);
//     // vm.prank(address(address()0x10000));
//     // levelOne_addTeacher(address(0x53647));
    
//     // vm.roll(24241);
//     // vm.warp(908434);
//     // vm.prank(address(address()0x20000));
//     // invariant_principalCannotBeTeacher();
//     // }

//     // forge test --match-test test_invariant_contractBalanceConsistency_0 -vvv 

//     // function test_invariant_contractBalanceConsistency_0() public {
    
//     // vm.roll(120);
//     // vm.warp(386795);
//     // levelOne_enroll();
    
//     // vm.roll(18275);
//     // vm.warp(747350);
//     // levelOne_graduateAndUpgrade(0x736F7e59748Fbbc3ceaeb8870a9C364Cc0B723D9, "");
    
//     // vm.roll(39426);
//     // vm.warp(1107625);
//     // invariant_contractBalanceConsistency();
//     // }


//     // forge test --match-test test_invariant_noDoubleSpending_0 -vvv 

//     function test_invariant_noDoubleSpending_0() public {
    
//     vm.roll(27);
//     vm.warp(38);
//     vm.prank(address(0x20000));
//     levelOne_enroll();
    
//     vm.roll(22717);
//     vm.warp(520649);
//     vm.prank(address(0x20000));
//     levelOne_graduateAndUpgrade(0x54919A19522Ce7c842E25735a9cFEcef1c0a06dA, "");
    
//     vm.roll(76698);
//     vm.warp(881239);
//     vm.prank(address(0x30000));
//     levelOne_graduateAndUpgrade(0xe9Ee6858A56f4207B3C82F3FC9C82636f515651e, "");
    
//     vm.roll(105626);
//     vm.warp(1341290);
//     vm.prank(address(0x30000));
//     levelOne_graduateAndUpgrade(0x736F7e59748Fbbc3ceaeb8870a9C364Cc0B723D9, "");
    
//     vm.roll(129511);
//     vm.warp(1701883);
//     vm.prank(address(0x30000));
//     levelOne_graduateAndUpgrade(0x5ab8921f4FCf62eaa779c7F04742efb855F65B0d, "5200657700616e6f0000006200007600006e65000000");
    
//     vm.roll(129511);
//     vm.warp(1701883);
//     vm.prank(address(0x10000));
//     levelOne_graduateAndUpgrade(0x38b3b548c9D05824d9bCd44561931Ef45734C98a, "006f6400006c79727469630077650020666f75666f727000006600006420636800");
    
//     vm.roll(147278);
//     vm.warp(1819747);
//     vm.prank(address(0x20000));
//     levelOne_graduateAndUpgrade(address(0x20000), "");
    
//     vm.roll(204044);
//     vm.warp(2424547);
//     vm.prank(address(0x10000));
//     levelOne_graduateAndUpgrade(0x01375317AA980daaBF22f990a378ECCaD9B40dc0, "");
    
//     vm.roll(216109);
//     vm.warp(2941414);
//     vm.prank(address(0x20000));
//     levelOne_graduateAndUpgrade(0xdbb516dbcC8c91A999eB6706cd0a03eAAfF6Cdc0, "");
    
//     vm.roll(224128);
//     vm.warp(3486745);
//     vm.prank(address(0x20000));
//     levelOne_graduateAndUpgrade(0x736F7e59748Fbbc3ceaeb8870a9C364Cc0B723D9, "");
    
//     vm.roll(237576);
//     vm.warp(4055028);
//     vm.prank(address(0x30000));
//     invariant_noDoubleSpending();
//     }
            
            

		
// }
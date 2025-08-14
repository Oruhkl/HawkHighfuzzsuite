
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import {LevelOne} from "src/LevelOne.sol";
import {MockUSDC} from "test/mocks/MockUSDC.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract Setup {
    LevelOne public levelOne;
    ERC1967Proxy public levelOneProxy;
    LevelOne public levelOneImpl;
    MockUSDC public usdc;
    uint256 public constant TEACHER_WAGE = 35; // 35%
    uint256 public constant PRINCIPAL_WAGE = 5; // 5%
    uint256 public constant PRECISION = 100;
    uint256 public constant SCHOOL_FEES = 5_000e18;
    address public principal = address(0x53647);
    function setUp() internal {
        usdc = new MockUSDC();

        levelOneImpl = new LevelOne();
        levelOneProxy = new ERC1967Proxy(
            address(levelOneImpl),
            abi.encodeWithSelector(LevelOne.initialize.selector, principal, SCHOOL_FEES, address(usdc))
        );
        levelOne = LevelOne(address(levelOneProxy));
    }
    

    
}
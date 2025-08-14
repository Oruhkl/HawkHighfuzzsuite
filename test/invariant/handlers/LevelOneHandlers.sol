// SPDX-License-Identifier: GPL-2.0
pragma solidity 0.8.26;

import {LevelOne} from "src/LevelOne.sol";
import {LibAddressSet} from "test/invariant/utils/LibAddressSet.sol";
import {Setup} from "test/invariant/Setup.sol";
import {StdCheats} from "test/invariant/utils/StdCheats.sol";
contract Handler is Setup {
    using LibAddressSet for LibAddressSet.AddressSet;

    LibAddressSet.AddressSet internal _actors;
    address currentActor;
    StdCheats public vm = StdCheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
   
    function levelOne_addTeacher(address _teacher) public {
        // Ensure we're not in session
        if (levelOne.getSessionStatus()) {
            return; // Skip if in session
        }
        
        _actors.addTeacher(_teacher);
        vm.prank(principal);
        levelOne.addTeacher(_teacher);
    }

    function levelOne_enroll() public asActor notTeacherOrPrincipal {
        // Check if already enrolled
        if (levelOne.isStudent(currentActor)) {
            return; // Skip if already enrolled
        }
        // Check session status
        if (levelOne.getSessionStatus()) {
            return; // Skip if in session
        }
        _actors.addStudent(currentActor);
        vm.prank(currentActor);
        levelOne.enroll();
    }

    function levelOne_expel(address _student) public {
        // Can only expel DURING session
        if (levelOne.getSessionStatus() == false) {
            return; // Skip if not in session
        }
        if (_actors.isStudent(_student)) {
            _actors.removeStudent(_student);
        }
        vm.prank(principal);
        levelOne.expel(_student);
    }

    function levelOne_giveReview(address _student, bool review) public {
        // Ensure caller is a teacher
        require(levelOne.isTeacher(msg.sender), "Only teacher can call this function");
        vm.prank(msg.sender);
        levelOne.giveReview(_student, review);
    }

    function levelOne_graduateAndUpgrade(address _levelTwo, bytes memory data) public {
        vm.prank(principal);
        levelOne.graduateAndUpgrade(_levelTwo, data);
    }

    function levelOne_initialize(address _principal, uint256 _schoolFees) public {
        levelOne.initialize(_principal, _schoolFees, address(usdc));
    }

    function levelOne_removeTeacher(address _teacher) public {
        if (_actors.isTeacher(_teacher)) {
            _actors.removeTeacher(_teacher);
        }
        vm.prank(principal);
        levelOne.removeTeacher(_teacher);
    }

    function levelOne_startSession(uint256 _cutOffScore) public {
        // Can only start when NOT in session
        require(!levelOne.getSessionStatus(), "Session already started");
        vm.prank(principal);
        levelOne.startSession(_cutOffScore);
    }

    function levelOne_upgradeToAndCall(address newImplementation, bytes memory data) public {
        vm.prank(principal);
        levelOne.upgradeToAndCall(newImplementation, data);
    }

    // Modifier to track actors
    modifier asActor() {
        currentActor = msg.sender;
        require(currentActor != address(0), "Cannot be zero address");
        usdc.mint(currentActor, type(uint256).max);
        vm.prank(currentActor);
        usdc.approve(address(levelOne), type(uint256).max);   
        _;
        currentActor = address(0);
    }

    modifier notTeacherOrPrincipal() {
        require(!_actors.isTeacher(currentActor) && currentActor != principal, "Teachers and principal cannot enroll");
        _;
    }

    // Helper functions to get tracked data
    function getTrackedTeachers() external view returns (address[] memory) {
        return _actors.getTeachers();
    }

    function getTrackedStudents() external view returns (address[] memory) {
        return _actors.getStudents();
    }

    function getTrackedTeacherCount() external view returns (uint256) {
        return _actors.getTeacherCount();
    }

    function getTrackedStudentCount() external view returns (uint256) {
        return _actors.getStudentCount();
    }

    function isTrackedTeacher(address addr) external view returns (bool) {
        return _actors.isTeacher(addr);
    }

    function isTrackedStudent(address addr) external view returns (bool) {
        return _actors.isStudent(addr);
    }
}
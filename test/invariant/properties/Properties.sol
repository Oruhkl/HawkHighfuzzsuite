// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import {Handler} from "test/invariant/handlers/LevelOneHandlers.sol";
import {PropertiesAsserts} from "test/invariant/utils/PropertiesHelper.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Properties is Handler, PropertiesAsserts{
    constructor() payable{
        setUp();
    }
    
    // Invariant properties 1: reviewCount MUST INCREASE after a positive review is given (BROKEN))
    function invariant_reviewCountIncreasesAfterPositiveReview(address _student) external {
        uint256 beforeCount = levelOne.getReviewCount(_student);
        levelOne_giveReview(_student, true);
        uint256 afterCount = levelOne.getReviewCount(_student);
        assertGt(afterCount, beforeCount, "Review count did not increase after positive review");
    }

    // // Invariant properties 2: Principal cannot be teachers (BROKEN)
    function invariant_principalCannotBeTeacher() public {
        assertWithMsg(!levelOne.isTeacher(principal), "Principal should not be a teacher");
    }

    //Invariant properties 3: Student score cannot exceed 100
    function invariant_studentScoresBounded() external {
        address[] memory students = levelOne.getListOfStudents();
        
        for (uint i = 0; i < students.length; i++) {
            uint256 score = levelOne.studentScore(students[i]);
            assertLte(score, 100, "Student score cannot exceed 100");
            // Score can be 0 or positive
        }
    }

    
    //Invariant properties 4: Review count cannot exceed 5
    function invariant_reviewCountWithinLimits() external {
        address[] memory students = levelOne.getListOfStudents();
        
        for (uint i = 0; i < students.length; i++) {
            uint256 reviewCount = levelOne.getReviewCount(students[i]);
            assertLte(reviewCount, 5, "Review count cannot exceed 5");
        }
    }

    //Invariant properties 5: Session end must be set when in session
    function invariant_sessionStateLogic() external {
        bool inSession = levelOne.getSessionStatus();
        uint256 sessionEnd = levelOne.getSessionEnd();
        
        if (inSession) {
            assertGt(sessionEnd, 0, "Session end must be set when in session");
        }
    }
     //Invariant properties 6: Bursary should equal total fees paid (BROKEN)
    function invariant_bursaryAccumulation() external {
        uint256 totalStudents = levelOne.getTotalStudents();
        uint256 schoolFees = levelOne.getSchoolFeesCost();
        uint256 expectedBursary = totalStudents * schoolFees;
        uint256 actualBursary = levelOne.bursary();
        
        assertEq(actualBursary, expectedBursary, "Bursary should equal total fees paid");
    }

    //Invariant properties 7: Contract balance should be at least bursary amount (BROKEN)
    function invariant_contractBalanceConsistency() public {
        address token = levelOne.getSchoolFeesToken();
        uint256 contractBalance = IERC20(token).balanceOf(address(levelOne));
        uint256 bursary = levelOne.bursary();
        
        assertGte(contractBalance, bursary, "Contract balance should be at least bursary amount");
    }

    //Invariant properties 8: Total wages cannot exceed 100%
    function invariant_paymentDistribution() external {
        uint256 teacherWage = levelOne.TEACHER_WAGE();
        uint256 principalWage = levelOne.PRINCIPAL_WAGE();
        uint256 precision = levelOne.PRECISION();
        
        assertEq(teacherWage, 35, "Teacher wage should be 35%");
        assertEq(principalWage, 5, "Principal wage should be 5%");
        assertEq(precision, 100, "Precision should be 100");
        
        // Total distributed should not exceed 100%
        assertLte(teacherWage + principalWage, precision, "Total wages cannot exceed 100%");
    }

    // Invariant properties 9: Too much money was distributed (BROKEN)
    function invariant_noDoubleSpending() public {
        address token = levelOne.getSchoolFeesToken();
        uint256 contractBalance = IERC20(token).balanceOf(address(levelOne));
        uint256 bursary = levelOne.bursary();
        
        // If graduation happened, check that remaining balance is reasonable
        if (bursary > 0) {
            // 60% should remain (100% - 35% teachers - 5% principal = 60%)
            uint256 expectedRemaining = (bursary * 60) / 100;
            assertGte(contractBalance, expectedRemaining, "Too much money was distributed");
        }
    }
}
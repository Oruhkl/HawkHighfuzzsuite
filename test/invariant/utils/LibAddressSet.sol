pragma solidity ^0.8.0;

library LibAddressSet {
    struct AddressSet {
        address[] teachers;
        address[] students;
        mapping(address => uint256) teacherIndex; // 1-based index (0 means not present)
        mapping(address => uint256) studentIndex; // 1-based index (0 means not present)
    }

    function addTeacher(AddressSet storage set, address addr) internal {
        require(addr != address(0), "Cannot add zero address");
        require(set.teacherIndex[addr] == 0, "Teacher already exists");
        
        set.teachers.push(addr);
        set.teacherIndex[addr] = set.teachers.length; // Store 1-based index
    }

    function addStudent(AddressSet storage set, address addr) internal {
        require(addr != address(0), "Cannot add zero address");
        require(set.studentIndex[addr] == 0, "Student already exists");
        
        set.students.push(addr);
        set.studentIndex[addr] = set.students.length; // Store 1-based index
    }

    function removeTeacher(AddressSet storage set, address addr) internal {
        uint256 index = set.teacherIndex[addr];
        require(index > 0, "Teacher not found");
        
        uint256 arrayIndex = index - 1; // Convert to 0-based
        uint256 lastIndex = set.teachers.length - 1;
        
        if (arrayIndex != lastIndex) {
            // Move last element to the position of element to remove
            address lastTeacher = set.teachers[lastIndex];
            set.teachers[arrayIndex] = lastTeacher;
            set.teacherIndex[lastTeacher] = index; // Update moved element's index
        }
        
        set.teachers.pop();
        delete set.teacherIndex[addr];
    }

    function removeStudent(AddressSet storage set, address addr) internal {
        uint256 index = set.studentIndex[addr];
        require(index > 0, "Student not found");
        
        uint256 arrayIndex = index - 1; // Convert to 0-based
        uint256 lastIndex = set.students.length - 1;
        
        if (arrayIndex != lastIndex) {
            // Move last element to the position of element to remove
            address lastStudent = set.students[lastIndex];
            set.students[arrayIndex] = lastStudent;
            set.studentIndex[lastStudent] = index; // Update moved element's index
        }
        
        set.students.pop();
        delete set.studentIndex[addr];
    }

    function isTeacher(AddressSet storage set, address addr) internal view returns (bool) {
        return set.teacherIndex[addr] > 0;
    }

    function isStudent(AddressSet storage set, address addr) internal view returns (bool) {
        return set.studentIndex[addr] > 0;
    }

    function getTeachers(AddressSet storage set) internal view returns (address[] memory) {
        return set.teachers;
    }

    function getStudents(AddressSet storage set) internal view returns (address[] memory) {
        return set.students;
    }

    function getTeacherCount(AddressSet storage set) internal view returns (uint256) {
        return set.teachers.length;
    }

    function getStudentCount(AddressSet storage set) internal view returns (uint256) {
        return set.students.length;
    }
}
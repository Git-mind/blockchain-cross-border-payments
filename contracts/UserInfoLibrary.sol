// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
library UserInfoLibrary {
    struct UserInfoStruct {
        address userAddress;
        string role;
        string firstName;
        string lastName;
        string country;
        string location;
        string nationality;
        bool isPoliticallyExposed;
    }

}

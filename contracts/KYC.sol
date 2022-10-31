// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./UserInfoLibrary.sol";

contract KYC{
    uint256 transactionCount;

    mapping(address => UserInfoLibrary.UserInfoStruct) userDict;

    //Onboard customer into the blockchain with the necessary information
    function onboarding(address payable userAddress, string memory role, string memory firstName, string memory lastName, string memory country, string memory location, string memory nationality, bool isPoliticallyExposed) public {
        transactionCount +=1;
        userDict[userAddress] = UserInfoLibrary.UserInfoStruct(userAddress, role, firstName, lastName, country, location, nationality,isPoliticallyExposed);    
    }

    // retrieve user info via user's account address
    function getUserInfo(address payable userAddress) public view returns(UserInfoLibrary.UserInfoStruct memory){
        return userDict[userAddress];
    }

    // check how many user is onboard on blockchain
    function getTransactionCount() public view returns(uint256){
        return transactionCount;
    }
}
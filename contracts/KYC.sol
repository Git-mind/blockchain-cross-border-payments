// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//test
//test commetns
//test comments
//hello
import "./UserInfoLibrary.sol";

contract KYC{
    uint256 transactionCount;

    mapping(address => UserInfoLibrary.UserInfoStruct) userDict;


    function onboarding(address payable userAddress, string memory role, string memory firstName, string memory lastName, string memory country, string memory location, string memory nationality, bool isPoliticallyExposed) public {
        transactionCount +=1;
        // transactions.push(TransferFundsStruck(msg.sender, receiver, amount, message, block.timestamp));
        userDict[userAddress] = UserInfoLibrary.UserInfoStruct(userAddress, role, firstName, lastName, country, location, nationality,isPoliticallyExposed);

    // emit TransferEvent(msg.sender, receiver, amount, message, block.timestamp);
    
    }

    function getUserInfo(address payable userAddress) public view returns(UserInfoLibrary.UserInfoStruct memory){
        // UserInfoStruct[] memory userInfo = new UserInfoStruct[](1);
        // userInfo[0] = userDict[userAddress];
        return userDict[userAddress];
    }

    function getTransactionCount() public view returns(uint256){
        return transactionCount;
    }
}
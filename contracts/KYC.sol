// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//test
//test commetns
//test comments
//hello
contract KYC{
    uint256 transactionCount;

    mapping(address => UserInfoStruct) userDict;

    struct UserInfoStruct{
        address userAddress;
        string role;
        string firstName;
        string lastName;
        // string country;
        // string location;
        // string email;
        // string nric;
        // string phoneNum;
        // string nationality;
        // uint256 timestamp;
        // test git changes
        // test git changes - xianwei
    }

    function onboarding(address payable userAddress, string memory role, string memory firstName, string memory lastName) public {
        transactionCount +=1;
        // transactions.push(TransferFundsStruck(msg.sender, receiver, amount, message, block.timestamp));
        userDict[userAddress] = UserInfoStruct(userAddress, role, firstName, lastName);

    // emit TransferEvent(msg.sender, receiver, amount, message, block.timestamp);
    
    }

    function getUserInfo(address payable userAddress) public view returns(UserInfoStruct[] memory){
        UserInfoStruct[] memory userInfo = new UserInfoStruct[](1);
        userInfo[0] = userDict[userAddress];
        return userInfo;
    }

    function getTransactionCount() public view returns(uint256){
        return transactionCount;
    }
}
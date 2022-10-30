// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./KYC.sol";

contract TransactionProcessing{
    event CreateLog(string firstName, uint256 timestamp);
    address payable public sender;
    address payable public receiver;
    address public kycAddress; 
    KYC public kyc; 

    constructor(address payable _receiver, address _kycAddress) payable {
        require(_receiver != address(0), "receiver = zero address");
        sender = payable(msg.sender);
        receiver = _receiver;
        kycAddress = _kycAddress;
        kyc = KYC(_kycAddress); 
    }

    function processing() public {
        
        //get sender userInfo
        string memory firstName = kyc.getUserInfo(sender).firstName;
        emit CreateLog(firstName, block.timestamp);

        // check sender AML
    }

    function sendViaCall() public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = receiver.call{value: getBalance()}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
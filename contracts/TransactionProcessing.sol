// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./KYC.sol";
import "./AML.sol";

contract TransactionProcessing{
    event CreateLog(string firstName, uint256 timestamp);
    event CreateAMLLog(bool amlResult, uint256 timestamp);

    address payable public sender;
    address payable public receiver;
    address public kycAddress; 
    KYC public kyc; 
    AML public aml;

    constructor(address payable _receiver, address _kycAddress, address _amlAddress) payable {
        require(_receiver != address(0), "receiver = zero address");
        sender = payable(msg.sender);
        receiver = _receiver;
        kycAddress = _kycAddress;
        kyc = KYC(_kycAddress); 
        aml = AML(_amlAddress);
    }

    function processing() public {
        
        // Check sender and receiver for suspicious activity 
        //KYC - get sender nationality
        string memory senderNationality = kyc.getUserInfo(sender).nationality;
        emit CreateLog(senderNationality, block.timestamp);

        // check sender AML
        bool senderAmlResult = aml.checkNationality(senderNationality);
        emit CreateAMLLog(senderAmlResult, block.timestamp);

        string memory receiverNationality = kyc.getUserInfo(receiver).nationality;
        emit CreateLog(receiverNationality, block.timestamp);

        // check sender AML
        bool receiverAmlResult = aml.checkNationality(receiverNationality);
        emit CreateAMLLog(receiverAmlResult, block.timestamp);


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
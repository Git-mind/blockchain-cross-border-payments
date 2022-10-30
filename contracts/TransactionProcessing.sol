// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./KYC.sol";
import "./AusAML.sol";
import "./SgAML.sol";
import "./UserInfoLibrary.sol";

contract TransactionProcessing {
    event CreateLog(string nationality, uint256 timestamp);
    event CreateAMLLog(bool amlResult, uint256 timestamp);

    event CreateTransferStatusLog(string transferStatus, uint256 timestamp);

    event testSgLog(bool sgAML);
    event testAusLog(bool ausAML);
    event testFinalLog(bool finalLog);
    event testSgResult(bool sgResult);

    address payable public sender;
    address payable public receiver;
    address public kycAddress;
    KYC public kyc;
    SgAML public sgAml;
    AusAML public ausAml;


    constructor(
        address payable _receiver,
        address _kycAddress,
        address _sgAmlAddress,
        address _ausAmlAddress
    ) payable {
        require(_receiver != address(0), "receiver = zero address");
        sender = payable(msg.sender);
        receiver = _receiver;
        kycAddress = _kycAddress;
        kyc = KYC(_kycAddress);
        sgAml = SgAML(_sgAmlAddress);
        ausAml = AusAML(_ausAmlAddress);
    }

    function processing() public {
        // Check sender and receiver for suspicious activity
        //KYC - get sender nationality

        UserInfoLibrary.UserInfoStruct memory senderUserInfo = kyc.getUserInfo(sender);
        UserInfoLibrary.UserInfoStruct memory receiverUserInfo = kyc.getUserInfo(
            receiver
        );

        //Check Singapore
        bool[] memory sgResults = new bool[](3);
        sgResults[0] = sgAml.checkNationality(senderUserInfo, receiverUserInfo);
        sgResults[1] = sgAml.checkPoliticalStatus(senderUserInfo, receiverUserInfo);
        sgResults[2] = sgAml.checkWantedIndividual(senderUserInfo, receiverUserInfo);
        emit testSgResult(sgResults[0]);
        emit testSgResult(sgResults[1]);
        emit testSgResult(sgResults[2]);

        // bool[] memory sgResults = [
        //     sgAml.checkNationality(senderUserInfo, receiverUserInfo),
        //     sgAml.checkPoliticalStatus(senderUserInfo, receiverUserInfo),
        //     sgAml.checkWantedIndividual(senderUserInfo, receiverUserInfo)
        // ];

        //Check Australia
        bool[] memory ausResults = new bool[](3);
        sgResults[0] = ausAml.checkNationality(senderUserInfo, receiverUserInfo);
        sgResults[1] = ausAml.checkPoliticalStatus(senderUserInfo, receiverUserInfo);
        sgResults[2] = ausAml.checkWantedIndividual(senderUserInfo, receiverUserInfo);

        // bool[] memory ausResults = [
        //     ausAml.checkNationality(senderUserInfo, receiverUserInfo),
        //     ausAml.checkPoliticalStatus(senderUserInfo, receiverUserInfo),
        //     ausAml.checkWantedIndividual(senderUserInfo, receiverUserInfo)
        // ];

        bool isSgValid=true;
        bool isAusValid=true;

        for (uint256 i = 0; i < sgResults.length; i++) {
            if (sgResults[i]) {
                isSgValid=false; 
                emit testSgLog(isSgValid);
                break;
            }
        }


        for (uint256 i = 0; i < ausResults.length; i++) {
            if (ausResults[i]) {
                isAusValid=false; 
                emit testAusLog(isAusValid);

                break;
            }
        }
        //did not pass AML/CTF for either countries 
        // require(!isSgValid || !isAusValid, "Failed AML checks for either countries");
        //Pass AML/CTF for either countries 
        emit testFinalLog(isSgValid && isAusValid);
        if(!isSgValid || !isAusValid){
            (bool sent, bytes memory data) = sender.call{value: getBalance()}("");
            emit CreateTransferStatusLog("Transfer failure - Failed AML checks for either countries, Ether transfer back to Sender.", block.timestamp);
            // require(sent, "Failed to send Ether");
        } else {
            (bool sent, bytes memory data) = receiver.call{value: getBalance()}("");
            emit CreateTransferStatusLog("Transfer successfully, Ether sent to Receiver.", block.timestamp);

        }
    }

    function transfer() public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = receiver.call{value: getBalance()}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

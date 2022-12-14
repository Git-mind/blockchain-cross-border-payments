// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./UserInfoLibrary.sol";

contract SgAML {
    event CreateNationalityErrorLog(string nationality, uint256 timestamp);
    event CreatePoliticallyExposedErrorLog(string politicallyExposed, uint256 timestamp);
    event CreateExceededMaxAmtErrorLog(string exceedAmt, uint256 timestamp);
    event CreateWantedIndividualErrorLog(string wantedInd, uint256 timestamp);

    string[] bannedCountries = ["Iraq", "North Korea", "Russia"];
    uint256 maxAmount = 30;
    address[] wantedIndividuals = [0x72A4Bbe493FC0A724460C9940eE6FAE5f9209D61];

    function checkNationality(
        UserInfoLibrary.UserInfoStruct memory senderUserInfo,
        UserInfoLibrary.UserInfoStruct memory receiverUserInfo
    ) public returns (bool) {
        //check if userNationality in bannedCountries
        for (uint256 i = 0; i < bannedCountries.length; i++) {
            if (
                keccak256(abi.encodePacked(bannedCountries[i])) ==
                keccak256(abi.encodePacked(senderUserInfo.nationality)) ||
                keccak256(abi.encodePacked(bannedCountries[i])) ==
                keccak256(abi.encodePacked(receiverUserInfo.nationality))
            ) {
                emit CreateNationalityErrorLog("User's Nationality is in banned countries", block.timestamp);
                return true;
            }
        }
        return false;
    }

    function checkPoliticalStatus(
        UserInfoLibrary.UserInfoStruct memory senderUserInfo,
        UserInfoLibrary.UserInfoStruct memory receiverUserInfo
    ) public returns (bool) {

        if(senderUserInfo.isPoliticallyExposed || receiverUserInfo.isPoliticallyExposed){
            emit CreatePoliticallyExposedErrorLog("User is politically exposed", block.timestamp);
            return true;
        }

        return false;
            
    }


    function checkWantedIndividual(
        UserInfoLibrary.UserInfoStruct memory senderUserInfo,
        UserInfoLibrary.UserInfoStruct memory receiverUserInfo
    ) public returns (bool) {
        for (uint256 i = 0; i < wantedIndividuals.length; i++) {
            if (
                (wantedIndividuals[i] == senderUserInfo.userAddress) ||
                (wantedIndividuals[i] == receiverUserInfo.userAddress)
                
            ) {
                emit CreateWantedIndividualErrorLog("wanted Individual", block.timestamp);
                return true;
            }
        }
        return false;
    }
}

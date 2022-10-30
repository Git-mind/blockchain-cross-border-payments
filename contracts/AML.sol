// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract AML{

    string[] bannedCountries;

    function checkNationality(string memory userNationality) public returns(bool){

        bannedCountries.push("Iran");
        bannedCountries.push("Afganistan");
        bannedCountries.push("Turkmenistan");
        bannedCountries.push("Kyrgyzstan");


        //check if userNationality in bannedCountries
        for (uint i = 0; i < bannedCountries.length; i++) {
            if (keccak256(abi.encodePacked(bannedCountries[i])) == keccak256(abi.encodePacked(userNationality))) {
            return true;
            }
        }

        return false;

    }
}
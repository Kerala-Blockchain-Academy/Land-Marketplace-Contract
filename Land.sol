// SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

contract LandRegistration {


    struct LandDetail {
        uint surveyNo;
        string district;
        string taluk;
        string village;
        uint blockNo;
        uint landValue; // in wei
        uint area;
        bool salesStatus;
    }
    
    mapping(uint => LandDetail) LandDetails;
    
    uint public registeredLandCount = 0;
    
    
    function registerNewLand(uint surveyNo, string memory district, string memory taluk, string memory village, uint blockNo, uint landValue, uint area) public {
        LandDetails[registeredLandCount] = LandDetail(surveyNo, district, taluk, village, blockNo, landValue, area, false);
        registeredLandCount += 1;
    }
    
    function getLandDetails(uint landID) view public returns(LandDetail memory) {
        return LandDetails[landID];
    }

}

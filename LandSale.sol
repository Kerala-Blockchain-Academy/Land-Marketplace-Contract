// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "./Land.sol"; 

contract LandSale is LandRegistration {
    
    struct BidDetail {
        uint256 highestBid;
        address highestBidder;
        mapping(address => uint256) bids;
        address[] bidders;
    }

    mapping(uint256 => BidDetail) BidDetails;

    function bid(uint256 landID) public payable {
        require(BidDetails[landID].bids[msg.sender] + msg.value > BidDetails[landID].highestBid, "cant't bid, make a higher Bid");
        BidDetails[landID].highestBidder = msg.sender;
        BidDetails[landID].bidders.push(msg.sender);
        BidDetails[landID].highestBid = BidDetails[landID].bids[msg.sender] + msg.value;
        BidDetails[landID].bids[msg.sender] += msg.value;
    }
    
    
    function acceptBid(uint256 landID) public  {
        payable(msg.sender).transfer(BidDetails[landID].highestBid);

        for (uint256 i = 0; i < BidDetails[landID].bidders.length; i++) {
            if (BidDetails[landID].bidders[i] == BidDetails[landID].highestBidder) {
                continue;
            }
            payable(BidDetails[landID].bidders[i]).transfer(BidDetails[landID].bids[BidDetails[landID].bidders[i]]);
        }
        LandDetails[landID].salesStatus = true;
    }
    
    fallback () external {
        revert();
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AutoMatchingDonation {
    address public owner;
    address public sponsor;

    uint256 public sponsorMatchCap;
    uint256 public sponsorMatchedAmount;

    event Donated(address indexed donor, uint256 amount);
    event Matched(address indexed sponsor, uint256 amount);
    event SponsorUpdated(address indexed newSponsor, uint256 newCap);

    mapping(address => uint256) public donorContributions;

    constructor(address _sponsor, uint256 _matchCap) {
        owner = msg.sender;
        sponsor = _sponsor;
        sponsorMatchCap = _matchCap;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier onlySponsor() {
        require(msg.sender == sponsor, "Not sponsor");
        _;
    }

    // Allow donors to donate
    function donate() external payable {
        require(msg.value > 0, "Zero donation");

        donorContributions[msg.sender] += msg.value;
        emit Donated(msg.sender, msg.value);

        uint256 matchAmount = msg.value;

        // Match only up to remaining cap
        if (sponsorMatchedAmount + matchAmount > sponsorMatchCap) {
            matchAmount = sponsorMatchCap - sponsorMatchedAmount;
        }

        if (matchAmount > 0 && address(this).balance >= matchAmount) {
            sponsorMatchedAmount += matchAmount;
            emit Matched(sponsor, matchAmount);
        }
    }

    // Sponsor deposits ETH separately to be used for matching
    function depositMatchingFunds() external payable onlySponsor {
        require(msg.value > 0, "Zero deposit");
    }

    // Owner can withdraw total donations including matching funds
    function withdraw(address payable to) external onlyOwner {
        require(to != address(0), "Invalid address");
        to.transfer(address(this).balance);
    }

    // Owner can change sponsor and cap
    function updateSponsor(address _newSponsor, uint256 _newCap) external onlyOwner {
        sponsor = _newSponsor;
        sponsorMatchCap = _newCap;
        sponsorMatchedAmount = 0;

        emit SponsorUpdated(_newSponsor, _newCap);
    }

    // Fallback to accept ETH
    receive() external payable {}
}

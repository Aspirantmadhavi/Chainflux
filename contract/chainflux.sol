// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CHAINFLUX Project Contract
 * @dev A simple smart contract demonstrating project registration, funding,
 *      and status retrieval on the blockchain.
 */
contract Project {
    
    struct ProjectInfo {
        string title;
        string description;
        address owner;
        uint256 fundsRaised;
    }

    ProjectInfo public project;

    event Funded(address indexed contributor, uint256 amount);
    event UpdatedDescription(string newDescription);

    constructor(string memory _title, string memory _description) {
        project = ProjectInfo({
            title: _title,
            description: _description,
            owner: msg.sender,
            fundsRaised: 0
        });
    }

    /**
     * @notice Allows anyone to fund the project
     */
    function fundProject() external payable {
        require(msg.value > 0, "Must send ETH to fund");
        project.fundsRaised += msg.value;
        emit Funded(msg.sender, msg.value);
    }

    /**
     * @notice Owner can update the project description
     * @param _newDescription The updated description string
     */
    function updateDescription(string calldata _newDescription) external {
        require(msg.sender == project.owner, "Only owner can update");
        project.description = _newDescription;
        emit UpdatedDescription(_newDescription);
    }

    /**
     * @notice Retrieve basic project details
     */
    function getProject()
        external
        view
        returns (string memory, string memory, address, uint256)
    {
        return (
            project.title,
            project.description,
            project.owner,
            project.fundsRaised
        );
    }
}


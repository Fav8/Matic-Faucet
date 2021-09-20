pragma solidity 0.7.6;
// SPDX-License-Identifier: UNLICENSED

import "@opengsn/contracts/src/BaseRelayRecipient.sol";

contract Faucet is BaseRelayRecipient {
    
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    
    event tokenTrasferiti(address _to);
    event tokenNonTrasferiti(address _to);
        
    
    function getBalanceOfAddress(address _address) public view returns(uint){
        return _address.balance;
    }
    
    function sendMoney() public payable {
    }
    function withdrawMoney(address payable _to) public {
        if(getBalanceOfAddress(_to) < 50000000000000000)
        {
        _to.transfer(50000000000000000);
        emit tokenTrasferiti(_to);
        }
        else emit tokenNonTrasferiti(_to);
    }

    receive() external payable{
        sendMoney();
    }
    
     function acceptRelayedCall(
        address relay,
        address from,
        bytes calldata encodedFunction,
        uint256 transactionFee,
        uint256 gasPrice,
        uint256 gasLimit,
        uint256 nonce,
        bytes calldata approvalData,
        uint256 maxPossibleCharge
    ) external view returns (uint256, bytes memory) {
        return _approveRelayedCall();
    }

    // We won't do any pre or post processing, so leave _preRelayedCall and _postRelayedCall empty
    function _preRelayedCall(bytes memory context) internal  returns (bytes32) {
    }

    function _postRelayedCall(bytes memory context, bool, uint256 actualCharge, bytes32) internal  {
    }
}
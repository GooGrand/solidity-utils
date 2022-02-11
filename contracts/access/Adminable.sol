// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { AddressArray } from "../libraries/AddressArray.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Adminable is Ownable {
    address[] _admins;

    modifier onlyAdmin() {
        require(msg.sender==owner() || AddressArray.indexOf(_admins, msg.sender) != -1, 
            "Compound: permitted to admins only");
        _;
    }

    function setAdmins(address[] memory admins) public onlyOwner {
        for(uint i = 0; i < admins.length; i++) {
            _admins.push(admins[i]);
        }
    }

    function removeAdmins(address[] memory admins) public onlyOwner {
        for(uint i = 0; i < admins.length; i++) {
            AddressArray.removeItem(_admins, admins[i]);
        }
    }

}
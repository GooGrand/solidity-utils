// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { AddressArray } from "../libraries/AddressArray.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an accounts list that can be granted exclusive access to
 * specific functions.
 *
 * By default, admins list is empty, you can update it with given methods like
 * setAdmins or removeAdmins
 *
 */
abstract contract Adminable is Ownable {
    /**
    * Contains the array of addresses that can access to functions
    * with modifier onlyAdmin
    */
    address[] _admins;

    /**
     * Modifier that restricts functions to use for addresses that are 
     * written to _address 
     */
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
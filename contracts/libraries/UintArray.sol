// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library UintArray {

    /**
     * Function that removes `item` from `array`.
     * In case of several `items` in array deletes the first one to match
     *
     */
    function removeItem(
        uint[] storage array,
        uint a
    ) internal {
        int i = indexOf(array, a);
        require(i != -1, "ARRAY_LIB: Element doesn't exist");
        remove(array, uint(i));
    }

    /**
     * Function removes specific `index` from `array`
     */
    function remove(      
        uint[] storage array,
        uint index
    ) internal {
        require(index <= array.length, "ARRAY_LIB: Index does not exist");
        array[index] = array[array.length-1];
        array.pop();
    }


    /**
     * Function allows to find index of given value in `array`
     * Shouldn't be used with a large array to save gas
     */
    function indexOf(
        uint[] storage array,
        uint a
    ) internal view returns (int) {
        if (array.length == 0) return int(-1); // we want to continue txn process
        for(uint i=0; i<array.length; i++) {
            if (array[i] == a) {
                return int(i);
            }
        }
        return int(-1);
    }
}
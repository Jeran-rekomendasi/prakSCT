// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "tests/NPWPVerification.sol";

contract NPWPVerificationTest {

    NPWPVerification npwpContract;

    string testNPWP = "1234567890";

    /// dijalankan sebelum test
    function beforeAll() public {
        npwpContract = new NPWPVerification();
    }

    /// TEST 1: cek deploy berhasil
    function checkAdmin() public {
        Assert.notEqual(
            npwpContract.admin(),
            address(0),
            "Admin tidak boleh address kosong"
        );
    }

    /// TEST 2: register NPWP
    function registerNPWPTest() public {
        npwpContract.registerNPWP(testNPWP, true);

        (
            bool exists,
            bool isActive,

        ) = npwpContract.verifyNPWP(testNPWP);

        Assert.equal(
            exists,
            true,
            "NPWP harus terdaftar"
        );

        Assert.equal(
            isActive,
            true,
            "NPWP harus aktif"
        );
    }

    /// TEST 3: update status NPWP
    function updateNPWPStatusTest() public {

        npwpContract.updateNPWPStatus(
            testNPWP,
            false
        );

        (
            ,
            bool isActive,

        ) = npwpContract.verifyNPWP(testNPWP);

        Assert.equal(
            isActive,
            false,
            "Status harus non-aktif"
        );
    }

    /// TEST 4: cek NPWP tidak terdaftar
    function verifyUnknownNPWP() public {

        (
            bool exists,
            ,
        ) = npwpContract.verifyNPWP("999999999");

        Assert.equal(
            exists,
            false,
            "NPWP tidak boleh ditemukan"
        );
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NPWPVerification {

    // Struktur data NPWP
    struct TaxPayer {
        string npwp;
        bool isActive;
        uint256 registeredAt;
    }

    // Mapping NPWP ke data wajib pajak
    mapping(string => TaxPayer) private taxpayers;

    // Admin contract
    address public admin;

    // Event untuk logging
    event NPWPRegistered(string npwp, bool status);
    event NPWPStatusUpdated(string npwp, bool status);

    // Modifier hanya admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Hanya admin yang boleh mengakses");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    // Fungsi untuk mendaftarkan NPWP
    function registerNPWP(string memory _npwp, bool _status) public onlyAdmin {
        require(bytes(taxpayers[_npwp].npwp).length == 0, "NPWP sudah terdaftar");

        taxpayers[_npwp] = TaxPayer({
            npwp: _npwp,
            isActive: _status,
            registeredAt: block.timestamp
        });

        emit NPWPRegistered(_npwp, _status);
    }

    // Fungsi untuk update status NPWP
    function updateNPWPStatus(string memory _npwp, bool _status) public onlyAdmin {
        require(bytes(taxpayers[_npwp].npwp).length != 0, "NPWP tidak ditemukan");

        taxpayers[_npwp].isActive = _status;

        emit NPWPStatusUpdated(_npwp, _status);
    }

    // Fungsi untuk verifikasi NPWP
    function verifyNPWP(string memory _npwp) public view returns (
        bool exists,
        bool isActive,
        uint256 registeredAt
    ) {
        if (bytes(taxpayers[_npwp].npwp).length == 0) {
            return (false, false, 0);
        }

        TaxPayer memory tp = taxpayers[_npwp];
        return (true, tp.isActive, tp.registeredAt);
    }

    // Fungsi untuk melihat detail NPWP (opsional)
    function getNPWPDetail(string memory _npwp) public view returns (TaxPayer memory) {
        require(bytes(taxpayers[_npwp].npwp).length != 0, "NPWP tidak ditemukan");
        return taxpayers[_npwp];
    }
}
// 1. Lisensi Kode
// SPDX-License-Identifier: MIT
// 2. Versi Compiler Solidity
pragma solidity ^0.8.0;
// 3. Definisi Contract
contract HelloBlockchain {
// 4. State Variable (Penyimpanan Data Permanen)
string public pesan;
address public pemilik;
// 5. Constructor (Dijalankan sekali saat deploy)
constructor(string memory _pesanAwal) {
pesan = _pesanAwal;
pemilik = msg.sender;
}
// 6. Fungsi untuk Mengubah Data (Write)

function ubahPesan(string memory _pesanBaru) public {
pesan = _pesanBaru;
}
// 7. Fungsi untuk Melihat Data (Read)
function lihatPesan() public view returns (string memory) {
return pesan;
}
}
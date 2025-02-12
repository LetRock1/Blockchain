// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MusicNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    struct MusicMetadata {
        string title;
        string artist;
        string ipfsHash; 
        uint256 timestamp;
    }

    mapping(uint256 => MusicMetadata) public musicData;

    event MusicNFTMinted(address indexed owner, uint256 indexed tokenId, string title, string artist, string ipfsHash);

    constructor() ERC721("MusicNFT", "MUSIC") {}

    function mintMusicNFT(
        string memory _title, 
        string memory _artist, 
        string memory _ipfsHash, 
        string memory _tokenURI
    ) public {
        _tokenIdCounter++;
        uint256 tokenId = _tokenIdCounter;

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);

        musicData[tokenId] = MusicMetadata(_title, _artist, _ipfsHash, block.timestamp);

        emit MusicNFTMinted(msg.sender, tokenId, _title, _artist, _ipfsHash);
    }

    function getMusicData(uint256 tokenId) public view returns (string memory, string memory, string memory, uint256) {
        require(_exists(tokenId), "Token does not exist");
        MusicMetadata memory music = musicData[tokenId];
        return (music.title, music.artist, music.ipfsHash, music.timestamp);
    }
}
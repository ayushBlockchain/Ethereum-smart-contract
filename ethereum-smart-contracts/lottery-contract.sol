//SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <=0.9.0;

/*
5 user (struct) .....  name , accountNo, balance = 10000, lotteryNo 
virtual acc 
allocation name , accNo , balance , lotteryNo
entry fee per user  1000    (and add in virtual acc)
check account >entry  +-
input lucky number
20% for virtual acc and 80 % as reward
virtual acc > reward  +-
display (lottery no , amount and name)
*/

/*
-- dynamic entry of user 
-- avoid string 
-- require          => if() ke sath revert()
-- avoid array      => mapping
-- avoid for loop   
-- use contract address instant of msg.sender to hold the money 
-- do not hardcode any value in contract
*/

contract CleanLottery {
    address public owner;
    uint256 public entryFee;
    uint256 public maxPlayers;
    uint256 public playerCount;
    uint256 public round;

    struct Player {
        address account;
        uint roundEntered;
    }

    mapping(address => Player) public participant;
    mapping(uint => address) private indexedPlayers;

    event Entered(address indexed player, uint index);
    event WinnerPicked(address indexed winner, uint prize);
    event TransferFailed(address indexed to, uint amount);

    constructor(uint _maxPlayers, uint _entryFee) {
        owner = msg.sender;
        maxPlayers = _maxPlayers;
        entryFee = _entryFee;
        round = 1;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function entry() external payable {
     
        participant[msg.sender] = Player(msg.sender, round);
        indexedPlayers[playerCount] = msg.sender;

        emit Entered(msg.sender, playerCount);

        playerCount++;
    }

    function pickWinner() external  {
        uint randomIndex = uint(block.prevrandao) % maxPlayers;    // generate one random index number and we assume that index is winner 
        address winner = indexedPlayers[randomIndex];                    // assign index in winner variable
        uint prize = address(this).balance;                              // assign balance into price variable 
 
        (bool success, ) = payable(winner).call{value: prize}("");      // send the winning amount 
        if (!success) {
            emit TransferFailed(winner, prize);          // failed
        }
        emit WinnerPicked(winner, prize);                                   

        playerCount = 0;
        round++; 
    }


    function getPlayerByIndex(uint index) external view returns (address) {
        return indexedPlayers[index];
    }

    
}
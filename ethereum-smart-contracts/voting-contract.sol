/*
two parties   
struct(participant name , symbol , serialNo) 
user define 10 (name , voterId )
user vote 
total votes count 
winner decide 
display winner with no of votes 

*/


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

struct party
{
        string symbol;
}
struct candidate
{
        string name ;
        party partyDetails;
}


struct voter 
{
    uint voterId;
    string name ;
    uint age;
    uint voteFor;
}


contract candidateRes
{
    candidate BJP = candidate("modi" , party("BJP"));
    candidate Congress = candidate("rahul" , party("Congress" ));
}


contract Voting
{   
    voter[10] voters;
    constructor(){
        voters[0] = voter(1234 , "ayush" , 18,1);
        voters[1] = voter(1111 , "rahul" , 19,2);
        voters[2] = voter(2222 , "anish" , 100,1);
        voters[3] = voter(3333 , "abhi" , 99,1);
        voters[4] = voter(4444 , "piyush" , 88,1);
        voters[5] = voter(5555 , "amit" , 21,1);
        voters[6] = voter(6666 , "deepesh" , 191,2);
        voters[7] = voter(7777, "jay" , 77,1);
        voters[8] = voter(8888 , "ajay" , 30,2);
        voters[9] = voter( 9999, "joti" , 19,1);
    }

    uint countBJPm ;
    uint countCongressm;

    function voteProcess() public returns(uint ,uint)
    {
        uint countBJP=0;
        uint countCongress=0;
        for(uint i=0 ; i< voters.length;i++)
        {

            if(voters[i].voteFor==1){
                countBJP++;
            }
            else{
                countCongress++;
            }
            
            countBJPm=countBJP;
            countCongressm = countCongress;
        }

        return (countBJPm, countCongressm);

    }


    function voteResult()public view returns(string memory, uint){
        if(countBJPm > countCongressm){
            return ("bjp", countBJPm );
        }
        else if(countBJPm < countCongressm){
            return ("congress", countCongressm);
        }
        else{
            return ("draw" , voters.length / 2);
        }

    }


}

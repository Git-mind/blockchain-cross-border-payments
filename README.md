# Blockchain-cross-border-payments : Easy Pay

## Set up 

  1. Download ganache-cli https://www.npmjs.com/package/ganache 

  2. Run this command on CMD : 
      ```
      ganache-cli --mnemonic "horn hammer original lemon chapter weird gun pond fortune blush cupboard cat" 
      ```
  3. Open Remix and choose Ganache provider and click enter 
      <img width="705" alt="image" src="https://user-images.githubusercontent.com/67952928/199008003-3f2b26d9-9da0-4ac1-8a6e-c8283510d67e.png">
    
## Deploy contracts

  1. Compile & Deploy SgAML smart contract with first account address
  
  2. Compile & Deploy AusAML smart contract with first account address
  
  3. Compile & Deploy KYC smart contract with first account address

## Succesful Transaction 

  1. Input sender and receiver details using onboarding function in KYC 
      ```
      Sender KYC information
      userAddress: 0x5fe9dD4c80ab7742B62Fb40CE1fBE37D226645A1
      Role: sender
      firstName: xian
      lastName: wei
      Country: Singapore
      Location: Singapore
      Nationality: Singapore	
      isPoliticallyExposed: false

      Receiver KYC information
      userAddress: 0xfB3Ce1611272f443B406BcE2e2dd1eEA85Ad340E
      Role: receiver	
      firstName: Aravind
      lastName: G
      Country: Australia
      Location: Australia
      Nationality: Australia	
      isPoliticallyExposed: false
      ```
  2. You can test the getUserInfo() function in KYC with either sender or receiver account address as parameter to retrieve their userInfo
  
  3. Compile & Deploy transactionProcessing smart contract with the sender (first) account address using the parameters given below.
      ```
      Parameter for deploy: receiver account address, KYC contract address, SgAML address, AusAML address
      Make sure the one deploying the smart contract is the sender with 50 ether as value. Once deployed,
      the transactionProcessing will hold the balance of 50 ether.
      ```
      
  4. Run processing function in transactionProcessing smart contract 
  
  
 ## Unsuccesful Transaction 
    
 1. Set the sender and receiver value like this 
 
 
    ```

    Sender KYC information
    userAddress: 0x5fe9dD4c80ab7742B62Fb40CE1fBE37D226645A1
    Role: sender
    firstName: xian
    lastName: wei
    Country: Iran
    Location: Iran
    Nationality: Iran	
    isPoliticallyExposed: true

    Receiver KYC information
    userAddress: 0xfB3Ce1611272f443B406BcE2e2dd1eEA85Ad340E
    Role: receiver	
    firstName: Aravind
    lastName: G
    Country: Iraq
    Location: Iraq
    Nationality: Iraq	
    isPoliticallyExposed: true
    ```  
2. Run processing function in transactionProcessing smart contract with 50 eth as value sent




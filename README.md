# hardhat way deploy
npx hardhat --network ropsten run scripts/deploy.js

# compile 
npx hardhat compile


# contract address

[https://rinkeby.etherscan.io/address/0xaf22d38178518f2fd91c63b8e11be077345adce0]

# ridox-contract
 
# create smart structure
brownie init

# test contract
brownie test

# compile smart contract
brownie compile

# deploy locally
brownie run scripts/deploy.py
brownie run scripts/1_deploy_token.py
brownie run scripts/helpful_scripts.py

# deploy on rinkeby network
brownie run scripts/1_deploy_token.py --network rinkeby



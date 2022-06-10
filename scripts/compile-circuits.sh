#!/bin/bash

cd circuits

mkdir MerkleTree
mkdir Deposit

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling circuit.circom..."

# compile circuit

circom merkleTree.circom --r1cs --wasm --sym -o MerkleTree
snarkjs r1cs info MerkleTree/merkleTree.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup MerkleTree/merkleTree.r1cs powersOfTau28_hez_final_14.ptau MerkleTree/circuit_0000.zkey
snarkjs zkey contribute MerkleTree/circuit_0000.zkey MerkleTree/circuit_final.zkey --name="r1" -v -e="=GYi-xAG+s94*g)YmlTTvzlaEJpk2=h0nuiP-iy=jFq)VAVKoiWRir@2OCyG9~0oAfK)(@6DsrsQ3eI-8dq9fmDQ9XTwY+KNfs9LhF+#J*)DJf&S%K7NAS=TCM5%wpML9vxJmq&EMagSmg~Xdp(wN8Y)N%TN000gLgdo2SnXCAw~~Twta5vit5NgSKNgaph32jkxhiatHftbZ_a4uXHD-l5(nrq^Yb%^iQ&h#HTwd@QhD8JZ-CHLEWnN&Q+39@0TAMkstdrnYWPy7=Jk53Pz&=0*(=!VLFe&qb1aM(OVSvnUkAWmBttlgw_0W~I!1+QZhR&NFL=iCT!qGwq~R-_G=irsOW#47s9lTE8Ci~NC4lqRhQ6e~Iy*r0G@81E5kC8KROA*qUa)FkNBY7KI9k8ftxi_ybUqCLtT@U~ZdES&91U7pV5bt1+U)LAd_YhXSF4*50P0qEgUA2ZMnVOhKvZg57qI*V~!j5Jzo)SQ6j3&B!%zGooLhKvUis=V3nP*29M33xdGEYDUu7&aJPPkA9(iSGB8iTVvAzhsKMRiS#y1ef#wE5H7d8Gt079W*km8lCah73Rhll@nyF)YAZZHgQ!1(npFI0qSLhvfX2mXWEIjXqVtkUtKhDvmuX(pj6S31puZqMb%donAqK233QXlL-+BLnO8hP^mYOHCEfi58YA)o%Vt6z6CnwyUn0xn%fVgfH#gsy%Qk&Z5L5=&038q+Q4~(W!qbl7Q0#iUdNpCQd*7GW5)u1iyM^pm8BZASMaTK3qSmHk%lxI2(AEPL9WfeZqVBf&Si1QZ@+P4ayB(Igf&vCYJn2!85xI+)FYP61X@Xmi~d8s&~U99E)dE%&~o8)xsADlEu~oo!!DM5j2C-heGOI0tMtMCG@HqIuY#V%DsMEkeZaT!63vD^IH0mAYVcf3kdPMtmS++UDwXa#66~&0YVyYFYt%XzfNG!Q)un^L9SYd*J)Xn4oULEV8FuqwPV!#pF6w3Fh1Ay2eMg5#N69tr9KY9-8qvSoq3"
snarkjs zkey contribute MerkleTree/circuit_0000.zkey MerkleTree/circuit_final.zkey --name="r2" -v -e="rIeYeGnnv#@BIQOyluk4@F+RzopudvLrZ-MAFa)Ff*F(&4@ody-3ptm8SDA@ZA2DXB9BTQ^f+Y9a%Fd-m@Fv%9e14!Z1RUrIzTjUPB^1YyeVAdi5EWtC0qzV~OaSoZsX7v6#sXjL9g4#heftb5HLCv!Na*BR#0)@PQie!6k!UdnMyBzvX3sMCdKV9=Ib2z22lE+bJ~rQoNzOv7WmqioVVgOD7dwVjCGTCK2!7DRAs*!-r&!e%!&fGl@uSppibaugaofIeALdiM1HLzgbIFC+x@*j)(qVwTW4q4A9u*)ZmrJURQm^a!qrRxmJP1(SZ6kQjOjz(O5MW4WK%+0UJpVrzHSF9v+PrbI=7E^MEPb3ZuDw6ux=ZvoyIn=deN1&WpmiOD#BkEbxZA2#&LZikeU6+hi#uMjEc+9C5300q0w)aN7o&Fjo*9hic)^!s7~FEB^gOs9Rmdk(wP4LmOl-dsw%&CRvh*%7AfyKJQM%*%viM&s%SP9p*JsXOjv_SW4UKYlQy8x(+#0U&Q5jKW84CMSJMQ=zXc!nLYj5Tw6xkMF58m9p2+oLu-*0L~CM1+XmeeMW*D47ca#aTA(xj+g2Xq9JINk=43=L5b3u!SR@-TuPs@0lWp!EpXWgjS6A0znt=DwQEvxZ+px%TA8W0luGjdSA+JF@4E)2ZwVrikT7Vq@nELQBMSrgzLj0ghYRPHoHGSBl2MmN!^3mY98)xznl-M0J3wVV@)O=S3)DzzrfoV76l4iKexUCd52(LJv&&idJyAz0Q~Z5uT-O06yHEwqorXtew6Jm4S&U%vc&7~TqrXYQO=O7B(G~IL99HEBVY4XStNHWxKhUu9AauAouoMW3fY92CuL3z6^i5Qx4B3n7oO)XQ@*md)+=zDGMDdbq6YuwRrnWjo68fKa9r1Z657b0FVX-rz~v-Vz6G&JGuhj7Q5A!Tz+rknBbC+=jTrSO-LHD-RRA#i4*QHrWkUqzP-WRReZyU&+~hjJSI#T&Ue0*IvPM)u9M(IA9jS3Z"
snarkjs zkey contribute MerkleTree/circuit_0000.zkey MerkleTree/circuit_final.zkey --name="r3" -v -e="~0NDGo1F*JwhM&b&x95-73*rVyc)!JuxysWcs1~HJg=YY_dgXeA(!6Vs**CUn8I)CTdkxDe&Tp1XyH155^fa~Y9lVDiY^DpGdL95u~#f*p(zw=dl=)!z(Jbl%-%zUV(qeAmhTfTLVW@mb_#BEYGOsASQh_q!aQZZpU-GvbfXzyIZ^7Y=V~qpX%@IywsutJ13ocN2lRPbg1gC~#n2ijKldotUrySUk1!Zbg&Po1zwxYLB9MX_uKG0k611GlJuYv=utR%YRqmmlWaYbF!K2hLswDX1-TvBbcWI-75OkkRpnP0&oLoFMa7_DhP5TyJu8-Kk3fDvK!T)b_sRcApnw@T+No)*iB@cLIuRCjflyxiBXs10C%PF!B7X3DdD~ECBm+AQq!IO@T@jLaRIi)phlGKTzxudl5ch(NX-oE+#YFD-VRoj7~FO-xqS%R(ps~i(hQzp1emN5igsC(^AIgkPobgPcZ~3zwo)XVH#MDGuUs)k5Gz_MYk&5O2k*Bv~g~kP*pFdJV-I-AEt6EzvZnvC~sAlyfBPWWIQ#GF0mh6*Be6*jYy(iY%ZHm3MABA~U&nO1=K&cI9~o^t&uKMrF3#vtij%cy7+(b~zM!aRCcK6^11ng#gqBF#F0*&dEkx^1juQ^mP6n_*J82eCSBeWhs4=8NDIPVP%gPh*ijR9P&j-WKGTkGA)c7KWo*N19&zf@eQyau!(fio-dLB#Add=Mn*Eg7tl5#O91vRo8o9x-91y1pMlWfw+6b7mtWmgfQ8WclUmNt3qbYD^7I^Qq*W9xRRw)dPmub5xKkLO&l~xNjM(l)W_LfWQD7lqxq%z+Qf_roce*dg+_p9F@eE=s86m_Bi(rlddB971Sn&mE_L0#jgR#98*rhC~!j4ZzRmXa2w%J^)wkao~sicQRRokfrNlO_S&^ZAM6g7!tufX_hK3eNkV~pI*sEMA_P(c2TqR^=soG@f5h!GkYmuAByAvYaT%=o)00Rmavx(v~yXW*1LI3qGxJG45=77B~J-&8vX^&8aun&wiyORV"
snarkjs zkey export verificationkey MerkleTree/circuit_final.zkey MerkleTree/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier MerkleTree/circuit_final.zkey ../contracts/MerkleTreeInclusionVerifier.sol

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling circuit.circom..."

# compile circuit

circom deposit.circom --r1cs --wasm --sym -o Deposit
snarkjs r1cs info Deposit/deposit.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup Deposit/deposit.r1cs powersOfTau28_hez_final_10.ptau Deposit/circuit_0000.zkey
snarkjs zkey contribute Deposit/circuit_0000.zkey Deposit/circuit_final.zkey --name="r1" -v -e="=GYi-xAG+s94*g)YmlTTvzlaEJpk2=h0nuiP-iy=jFq)VAVKoiWRir@2OCyG9~0oAfK)(@6DsrsQ3eI-8dq9fmDQ9XTwY+KNfs9LhF+#J*)DJf&S%K7NAS=TCM5%wpML9vxJmq&EMagSmg~Xdp(wN8Y)N%TN000gLgdo2SnXCAw~~Twta5vit5NgSKNgaph32jkxhiatHftbZ_a4uXHD-l5(nrq^Yb%^iQ&h#HTwd@QhD8JZ-CHLEWnN&Q+39@0TAMkstdrnYWPy7=Jk53Pz&=0*(=!VLFe&qb1aM(OVSvnUkAWmBttlgw_0W~I!1+QZhR&NFL=iCT!qGwq~R-_G=irsOW#47s9lTE8Ci~NC4lqRhQ6e~Iy*r0G@81E5kC8KROA*qUa)FkNBY7KI9k8ftxi_ybUqCLtT@U~ZdES&91U7pV5bt1+U)LAd_YhXSF4*50P0qEgUA2ZMnVOhKvZg57qI*V~!j5Jzo)SQ6j3&B!%zGooLhKvUis=V3nP*29M33xdGEYDUu7&aJPPkA9(iSGB8iTVvAzhsKMRiS#y1ef#wE5H7d8Gt079W*km8lCah73Rhll@nyF)YAZZHgQ!1(npFI0qSLhvfX2mXWEIjXqVtkUtKhDvmuX(pj6S31puZqMb%donAqK233QXlL-+BLnO8hP^mYOHCEfi58YA)o%Vt6z6CnwyUn0xn%fVgfH#gsy%Qk&Z5L5=&038q+Q4~(W!qbl7Q0#iUdNpCQd*7GW5)u1iyM^pm8BZASMaTK3qSmHk%lxI2(AEPL9WfeZqVBf&Si1QZ@+P4ayB(Igf&vCYJn2!85xI+)FYP61X@Xmi~d8s&~U99E)dE%&~o8)xsADlEu~oo!!DM5j2C-heGOI0tMtMCG@HqIuY#V%DsMEkeZaT!63vD^IH0mAYVcf3kdPMtmS++UDwXa#66~&0YVyYFYt%XzfNG!Q)un^L9SYd*J)Xn4oULEV8FuqwPV!#pF6w3Fh1Ay2eMg5#N69tr9KY9-8qvSoq3"
snarkjs zkey contribute Deposit/circuit_0000.zkey Deposit/circuit_final.zkey --name="r2" -v -e="rIeYeGnnv#@BIQOyluk4@F+RzopudvLrZ-MAFa)Ff*F(&4@ody-3ptm8SDA@ZA2DXB9BTQ^f+Y9a%Fd-m@Fv%9e14!Z1RUrIzTjUPB^1YyeVAdi5EWtC0qzV~OaSoZsX7v6#sXjL9g4#heftb5HLCv!Na*BR#0)@PQie!6k!UdnMyBzvX3sMCdKV9=Ib2z22lE+bJ~rQoNzOv7WmqioVVgOD7dwVjCGTCK2!7DRAs*!-r&!e%!&fGl@uSppibaugaofIeALdiM1HLzgbIFC+x@*j)(qVwTW4q4A9u*)ZmrJURQm^a!qrRxmJP1(SZ6kQjOjz(O5MW4WK%+0UJpVrzHSF9v+PrbI=7E^MEPb3ZuDw6ux=ZvoyIn=deN1&WpmiOD#BkEbxZA2#&LZikeU6+hi#uMjEc+9C5300q0w)aN7o&Fjo*9hic)^!s7~FEB^gOs9Rmdk(wP4LmOl-dsw%&CRvh*%7AfyKJQM%*%viM&s%SP9p*JsXOjv_SW4UKYlQy8x(+#0U&Q5jKW84CMSJMQ=zXc!nLYj5Tw6xkMF58m9p2+oLu-*0L~CM1+XmeeMW*D47ca#aTA(xj+g2Xq9JINk=43=L5b3u!SR@-TuPs@0lWp!EpXWgjS6A0znt=DwQEvxZ+px%TA8W0luGjdSA+JF@4E)2ZwVrikT7Vq@nELQBMSrgzLj0ghYRPHoHGSBl2MmN!^3mY98)xznl-M0J3wVV@)O=S3)DzzrfoV76l4iKexUCd52(LJv&&idJyAz0Q~Z5uT-O06yHEwqorXtew6Jm4S&U%vc&7~TqrXYQO=O7B(G~IL99HEBVY4XStNHWxKhUu9AauAouoMW3fY92CuL3z6^i5Qx4B3n7oO)XQ@*md)+=zDGMDdbq6YuwRrnWjo68fKa9r1Z657b0FVX-rz~v-Vz6G&JGuhj7Q5A!Tz+rknBbC+=jTrSO-LHD-RRA#i4*QHrWkUqzP-WRReZyU&+~hjJSI#T&Ue0*IvPM)u9M(IA9jS3Z"
snarkjs zkey contribute Deposit/circuit_0000.zkey Deposit/circuit_final.zkey --name="r3" -v -e="~0NDGo1F*JwhM&b&x95-73*rVyc)!JuxysWcs1~HJg=YY_dgXeA(!6Vs**CUn8I)CTdkxDe&Tp1XyH155^fa~Y9lVDiY^DpGdL95u~#f*p(zw=dl=)!z(Jbl%-%zUV(qeAmhTfTLVW@mb_#BEYGOsASQh_q!aQZZpU-GvbfXzyIZ^7Y=V~qpX%@IywsutJ13ocN2lRPbg1gC~#n2ijKldotUrySUk1!Zbg&Po1zwxYLB9MX_uKG0k611GlJuYv=utR%YRqmmlWaYbF!K2hLswDX1-TvBbcWI-75OkkRpnP0&oLoFMa7_DhP5TyJu8-Kk3fDvK!T)b_sRcApnw@T+No)*iB@cLIuRCjflyxiBXs10C%PF!B7X3DdD~ECBm+AQq!IO@T@jLaRIi)phlGKTzxudl5ch(NX-oE+#YFD-VRoj7~FO-xqS%R(ps~i(hQzp1emN5igsC(^AIgkPobgPcZ~3zwo)XVH#MDGuUs)k5Gz_MYk&5O2k*Bv~g~kP*pFdJV-I-AEt6EzvZnvC~sAlyfBPWWIQ#GF0mh6*Be6*jYy(iY%ZHm3MABA~U&nO1=K&cI9~o^t&uKMrF3#vtij%cy7+(b~zM!aRCcK6^11ng#gqBF#F0*&dEkx^1juQ^mP6n_*J82eCSBeWhs4=8NDIPVP%gPh*ijR9P&j-WKGTkGA)c7KWo*N19&zf@eQyau!(fio-dLB#Add=Mn*Eg7tl5#O91vRo8o9x-91y1pMlWfw+6b7mtWmgfQ8WclUmNt3qbYD^7I^Qq*W9xRRw)dPmub5xKkLO&l~xNjM(l)W_LfWQD7lqxq%z+Qf_roce*dg+_p9F@eE=s86m_Bi(rlddB971Sn&mE_L0#jgR#98*rhC~!j4ZzRmXa2w%J^)wkao~sicQRRokfrNlO_S&^ZAM6g7!tufX_hK3eNkV~pI*sEMA_P(c2TqR^=soG@f5h!GkYmuAByAvYaT%=o)00Rmavx(v~yXW*1LI3qGxJG45=77B~J-&8vX^&8aun&wiyORV"
snarkjs zkey export verificationkey Deposit/circuit_final.zkey Deposit/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier Deposit/circuit_final.zkey ../contracts/DepositVerifier.sol

cd ..
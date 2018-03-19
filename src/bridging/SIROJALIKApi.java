package bridging;

import java.security.MessageDigest;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;

public class SIROJALIKApi {        
public String getMd5(String data) throws NoSuchAlgorithmException {
    String result=data;
    if(data!=null)
    {
        MessageDigest md =MessageDigest.getInstance("MD5");
    
    md.update(data.getBytes());
    BigInteger hash = new BigInteger(1,md.digest());
    result = hash.toString(16);
    while(result.length()<32)
    {
        result="0"+result;
    }
    }
    return result;
    
}
}

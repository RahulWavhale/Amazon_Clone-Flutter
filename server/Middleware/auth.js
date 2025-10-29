const jwt = require('jsonwebtoken');

const auth = async(req,res,next)=>{
    const token = req.headers['token'];
    if(!token){
        return res.status(401).json({msg:"Token is not valid,unauthorize"});
    }
    const isVerifyStamp = jwt.verify(token,  process.env.JWT_SECRET || 'defaultSecretKey');
    if (!isVerifyStamp) {
        return res.status(401).json({msg:"Token Verification Failed"});
    }
    res.user = isVerifyStamp.id;
    req.token = token;
}


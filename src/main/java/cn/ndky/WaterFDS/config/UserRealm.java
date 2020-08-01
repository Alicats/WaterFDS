package cn.ndky.WaterFDS.config;


import cn.ndky.WaterFDS.common.status.AccountStatus;
import cn.ndky.WaterFDS.mapper.UserMapper;
import cn.ndky.WaterFDS.pojo.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserMapper userMapper;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principal) {
        SimpleAuthorizationInfo info = null;
        User user = (User) principal.getPrimaryPrincipal();
        if(user != null){
            info = new SimpleAuthorizationInfo();
            info.addRole(user.getRoleId());
        }

        return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        SimpleAuthenticationInfo info = null;
        UsernamePasswordToken upToken = (UsernamePasswordToken)token;

        String userId = upToken.getUsername();
        User user = userMapper.getUserByUserId(userId);
        if(user!=null){
            if (user.getStatus() == AccountStatus.LOCKED.getCode()){
                throw new LockedAccountException("账号被禁用,请联系管理员!");
            }

            info = new SimpleAuthenticationInfo(user,user.getPassword(), ByteSource.Util.bytes(user.getUserId()),getName());
        }

        return info;
    }
}

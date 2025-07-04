package kr.or.ddit.vo;

import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {

    private UserVO user;

    public CustomUser(UserVO user) {
        super(user.getUserId(),
              user.getUserPw(),
              user.isUserStatus(),      // userStatus
              true, 					// accountNonExpired
              true,                     // credentialsNonExpired
              true,                     // accountNonLocked
              user.getAuthList().stream()
                  .map(SimpleGrantedAuthority::new)
                  .collect(Collectors.toList())
        );
        this.user = user;
    }

    @Override
    public boolean isEnabled() {
        return !user.isUserStatus();  
    }
}

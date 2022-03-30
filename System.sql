-- kh / kh 계정 생성
create user kh identified by kh;

-- 권한 부여 -> 접속 / 리소스 
-- grant 부여할 권한/롤 to 계정명

grant connect, resource to kh;



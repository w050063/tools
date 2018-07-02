- 统计激活码使用情况
``` sql
select count(*) from coupons_register20180315 where updated_at <> "";     -- 使用激活码数量
select * from coupons_register20180315 where updated_at <> "";            -- 保存即可
```

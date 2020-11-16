# tcj - Trash Can Jam

game
wip

Remember the good old times in your classroom.  
The clock has 3 seconds left... 3 ... 2 ... 1 DAGGER!!!
___

- [ ] impl: UpsertProfileHandler
- [ ] impl: ReadProfleHandler
- [ ] impl: DeleteProfileHandler
- [ ] impl: use S3 instead of dynamo
- [ ] think about best practice testing test_profiles_upsert_413


#### change_log
- [x] switch from set-env to environment files
- [x] avoid pasting ids / use profileNames
- [x] authentication is not required

if authenticiation is required
- [ ] implement authenticiation / AWS Cognito
- [ ] add test_profiles_upsert_401 when authenticiation is impl

# CLI Starter
```
1회 IGA 발표에서 내용으로 Swift 를 이용해서 CommandLine Interface를 만드는 방법에 대한 예시 코드입니다.
```
### Preview

https://github.com/Jihoonahn/CLI-Starter/assets/68891494/ba23e33d-8e85-4d28-bc35-8f9acc0ab5ec



### Installation
```
$ git clone https://github.com/Jihoonahn/CLI-Starter
$ cd CLI-Starter
$ make
```

## Description
CLI-Starter 프로젝트에서 제공되는 ``command`` 와 ``subcommand`` 에 대한 설명입니다.

```
OVERVIEW: CLI Example for iGA Conference

This is an example of how the CLI works

USAGE: gpt [--message <message>] [--model <model>] <subcommand>

OPTIONS:
  -m, --message <message> Send a message
  --model <model>         The id of the OpenAI model to run (default: Model(id: "gpt-3.5-turbo-0301", contextLength: 4096))
  -h, --help              Show help information.

SUBCOMMANDS:
  open                    Open Safari website
  token                   Manage API tokens

  See 'gpt help <subcommand>' for detailed help.
```

### command

검색을 하기 위해서는 

```
$ gpt -m "원하는 메시지"
```
를 넣으면 default로 설정된 모델을 이용할 수 있고

```
$ gpt -m "원하는 메시지" --model "모델 이름"
```

다른 모델을 이용하고 싶다면 이렇게 바꿔주면 됩니다.

### subcommand

#### Open
api token을 발급 받는 웹페이지로 이동하고 싶을 때
```
$ gpt open
```
명령어를 사용하면 됩니다.
Safari 앱에서 [API Token 발급을 위한 페이지](https://platform.openai.com/account/api-keys) 로 이동합니다.

#### Token
발급 받은 토큰을 Keychain에 저장할 수 있는 기능을 제공합니다.

```
$ gpt token -s "발급받은 Token"
```

발급받은 토큰을 해당 명령어를 통해 저장할 수 있으며

```
$ gpt token -l
```

위 명령어를 통해서 발급 받은 Token에 대한 정보를 확인 할 수 있습니다.

```
$ gpt token -d
```

토큰을 삭제하기 위해서는 위 명령어를 지원합니다.

## License
**CLI Starter** is under MIT license. See the [LICENSE](LICENSE) file for more info.

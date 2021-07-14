go_get(
    name = "terratest",
    get = "github.com/gruntwork-io/terratest",
    install = [
        "collections",
        "aws",
        "customererrors",
        "files",
        "environment",
        "logger",
        "random",
        "retry",
        "shell",
        "ssh",
        "terraform",
    ],
    deps = [
        ":awssdk",
        ":crypto",
        ":net",
        ":mysql",
        ":testify",
        ":otp",
        ":uuid",
        ],
)

go_get(
    name = "testify",
    get = "github.com/stretchr/testify",
    install = [
        "assert",
        "require",
        "vendor/github.com/davecgh/go-spew/spew",
        "vendor/github.com/pmezard/go-difflib/difflib",
    ],
    test_only = True,
    deps = [
        ":yaml",
    ],
)

go_get(
    name = 'yaml',
    get = 'gopkg.in/yaml.v2',
    test_only = True,
)

go_get(
    name = "awssdk",
    get = "github.com/aws/aws-sdk-go",
    install = [
        'models/...',
        'internal/...',
        'private/...',
        'service/...',
        'aws/...',
        'vendor.github.com/jmespath/go=jmespath',
    ],
    test_only = True,
    deps = [
        ":net",
    ],
)

go_get(
    name = "crypto",
    get = "golang.org/x/crypto/...",
    test_only = True,
    deps = [
        ":net",
        ":sys",
    ],
)

go_get(
    name = "sys",
    get = "golang.org/x/sys/...",
    test_only = True,
)

go_get(
    name = "net",
    get = "golang.org/x/net",
    install = [
        "context",
        "http2",
        "idna",
    ],
    test_only = True,
    deps = [
        ":text",
    ],
)

go_get(
    name = "text",
    get = "golang.org/x/text",
    install = [
        "secure",
        "unicode",
    ],
    test_only = True,
)

go_get(
    name = "mysql",
    get = "github.com/go-sql-driver/mysql",
    test_only = True,
)

go_get(
    name = "otp",
    get = "github.com/pquerna/otp",
    install = [
        '',
        'hotp',
        'totp',
    ],
    test_only = True,
    deps = [
        ':barcode',
    ]
)

go_get(
    name = "barcode",
    get = "github.com/boombuler/barcode/...",
    test_only = True,
)

go_get(
    name = "uuid",
    get = "github.com/google/uuid",
    test_only = True,
)
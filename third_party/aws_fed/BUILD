project_name = "auth"

filegroup(
    name = "aws_fed",
    srcs = [
        # "aws-fed.toml",
        "federate.sh",
    ],
)

sh_binary(
    deps = [":aws_fed"],
    main = "federate.sh",
    name = "federate",
)
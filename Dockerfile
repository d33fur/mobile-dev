FROM swift:latest AS build

COPY labs/lab1/hello.swift /src/

WORKDIR /src/

RUN [ "/usr/bin/swiftc", "-static-executable", "hello.swift", "-o", "hello" ]



FROM scratch AS deploy

COPY --from=build /src/hello /hello

ENTRYPOINT ["/hello"]
//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: proto/backend.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `FetcherClient`, then call methods of this protocol to make API calls.
internal protocol FetcherClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: FetcherClientInterceptorFactoryProtocol? { get }

  func fetchURL(
    _ request: URLRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<URLRequest, URLReply>
}

extension FetcherClientProtocol {
  internal var serviceName: String {
    return "Fetcher"
  }

  /// Unary call to FetchURL
  ///
  /// - Parameters:
  ///   - request: Request to send to FetchURL.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func fetchURL(
    _ request: URLRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<URLRequest, URLReply> {
    return self.makeUnaryCall(
      path: FetcherClientMetadata.Methods.fetchURL.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeFetchURLInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension FetcherClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "FetcherNIOClient")
internal final class FetcherClient: FetcherClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: FetcherClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: FetcherClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the Fetcher service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: FetcherClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct FetcherNIOClient: FetcherClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: FetcherClientInterceptorFactoryProtocol?

  /// Creates a client for the Fetcher service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: FetcherClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol FetcherAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: FetcherClientInterceptorFactoryProtocol? { get }

  func makeFetchURLCall(
    _ request: URLRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<URLRequest, URLReply>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension FetcherAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return FetcherClientMetadata.serviceDescriptor
  }

  internal var interceptors: FetcherClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeFetchURLCall(
    _ request: URLRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<URLRequest, URLReply> {
    return self.makeAsyncUnaryCall(
      path: FetcherClientMetadata.Methods.fetchURL.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeFetchURLInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension FetcherAsyncClientProtocol {
  internal func fetchURL(
    _ request: URLRequest,
    callOptions: CallOptions? = nil
  ) async throws -> URLReply {
    return try await self.performAsyncUnaryCall(
      path: FetcherClientMetadata.Methods.fetchURL.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeFetchURLInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct FetcherAsyncClient: FetcherAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: FetcherClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: FetcherClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol FetcherClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'fetchURL'.
  func makeFetchURLInterceptors() -> [ClientInterceptor<URLRequest, URLReply>]
}

internal enum FetcherClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "Fetcher",
    fullName: "Fetcher",
    methods: [
      FetcherClientMetadata.Methods.fetchURL,
    ]
  )

  internal enum Methods {
    internal static let fetchURL = GRPCMethodDescriptor(
      name: "FetchURL",
      path: "/Fetcher/FetchURL",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol FetcherProvider: CallHandlerProvider {
  var interceptors: FetcherServerInterceptorFactoryProtocol? { get }

  func fetchURL(request: URLRequest, context: StatusOnlyCallContext) -> EventLoopFuture<URLReply>
}

extension FetcherProvider {
  internal var serviceName: Substring {
    return FetcherServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "FetchURL":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<URLRequest>(),
        responseSerializer: ProtobufSerializer<URLReply>(),
        interceptors: self.interceptors?.makeFetchURLInterceptors() ?? [],
        userFunction: self.fetchURL(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol FetcherAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: FetcherServerInterceptorFactoryProtocol? { get }

  func fetchURL(
    request: URLRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> URLReply
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension FetcherAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return FetcherServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return FetcherServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: FetcherServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "FetchURL":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<URLRequest>(),
        responseSerializer: ProtobufSerializer<URLReply>(),
        interceptors: self.interceptors?.makeFetchURLInterceptors() ?? [],
        wrapping: { try await self.fetchURL(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol FetcherServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'fetchURL'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeFetchURLInterceptors() -> [ServerInterceptor<URLRequest, URLReply>]
}

internal enum FetcherServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "Fetcher",
    fullName: "Fetcher",
    methods: [
      FetcherServerMetadata.Methods.fetchURL,
    ]
  )

  internal enum Methods {
    internal static let fetchURL = GRPCMethodDescriptor(
      name: "FetchURL",
      path: "/Fetcher/FetchURL",
      type: GRPCCallType.unary
    )
  }
}
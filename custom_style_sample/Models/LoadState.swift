public enum LoadState<V> {
  case idle
  case loading(skelton: V? = nil)
  case success(V)
  case failure(any Error)
}

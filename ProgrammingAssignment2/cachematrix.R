## Caching matrix inversion to speed up processing
## with special scoping to preserve state.
## Matrices are not checked whether they are invertible.

## Creates a matrix object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(solve) m <<- solve
    getinverse <- function() m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## Returns a matrix that is the inverse of 'x'.
## It computes the inverse of the special "matrix" returned by makeCacheMatrix.
## If the inverse of 'x' exists in the cache it will return the inverse from the cache.

cacheSolve <- function(x, ...) {
    m <- x$getinverse()
    if(!is.null(m)) {
         message("getting cached data")
         return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}

# CS 570
# HW 5
# Matt Dickenson
# 11/20/14

# Set up transition matrices
drive     = matrix(NA, nrow=3, ncol=3)
not.drive = matrix(NA, nrow=3, ncol=3)
states  = c("top", "rolling", "bottom")
actions = c("drive", "not.drive")

rownames(drive) = rownames(not.drive) = states
colnames(drive) = colnames(not.drive) = states

drive["top", "top"]         = .9
drive["top", "rolling"]     = .1
drive["top", "bottom"]      = .0
drive["rolling", "top"]     = .3
drive["rolling", "rolling"] = .6
drive["rolling", "bottom"]  = .1
drive["bottom", "top"]      = .6
drive["bottom", "rolling"]  = 0
drive["bottom", "bottom"]   = .4

not.drive["top", "top"]         = .7
not.drive["top", "rolling"]     = .3
not.drive["top", "bottom"]      = .0
not.drive["rolling", "top"]     = 0
not.drive["rolling", "rolling"] = 0
not.drive["rolling", "bottom"]  = 1
not.drive["bottom", "top"]      = 0
not.drive["bottom", "rolling"]  = 0
not.drive["bottom", "bottom"]   = 1

# Set up utility matrix
utils = matrix(NA, nrow=3, ncol=2)
rownames(utils) = states
colnames(utils) = actions
utils["top", "drive"]         = 2
utils["top", "not.drive"]     = 3
utils["rolling", "drive"]     = 0
utils["rolling", "not.drive"] = 1
utils["bottom", "drive"]      = 0
utils["bottom", "not.drive"]  = 1


##################################
### Problem 2 
##################################

delta     = 0.8
max_iters = 25
v = matrix(0, nrow=length(states), ncol=max_iters)
rownames(v) = rownames(a) = states
options = list("drive" = 0, "not.drive" = 0)

iters = 2
while (iters <= max_iters) {
	for (state in states){
		for(action in actions){
			options[action][[1]] = utils[state, action]
			for(next.state in states){
				cmd = paste(action, '["', state, '", "', next.state, '"]', sep="")
				p = eval(parse(text=cmd))
				options[action][[1]] = options[action][[1]] + 
					delta * p * v[next.state, iters-1]
			}
		}
		o = unlist(options)
		v[state, iters] = max(o)
	}
	iters = iters + 1
}

v[ , max_iters]




##################################
### Problem 3
##################################

delta     = 0.8
max_iters = 25
v = matrix(0, nrow=length(states), ncol=max_iters)
a = matrix(NA, nrow=length(states), ncol=max_iters)
rownames(v) = rownames(a) = states
options = list("drive" = 0, "not.drive" = 0)

a[ , 1] = rep(which(actions=="not.drive"), 3)
v[ , 1] = utils[ , 2]

iters = 2
while (iters <= max_iters) {
	for (state in states){
		for(action in actions){
			options[action][[1]] = utils[state, action]
			for(next.state in states){
				cmd = paste(action, '["', state, '", "', next.state, '"]', sep="")
				p = eval(parse(text=cmd))
				options[action][[1]] = options[action][[1]] + 
					delta * p * v[next.state, iters-1]
			}
		}
		o = unlist(options)
		v[state, iters] = max(o)
		a[state, iters] = which(o==max(o))
	}
	iters = iters + 1
}


##################################
### Problem 4
##################################

# Changing delta
delta = 0.5

# Changing transition probabilities
delta = 0.8
not.drive["rolling", "top"]     = 0
not.drive["rolling", "rolling"] = 1
not.drive["rolling", "bottom"]  = 0

# Changing payoffs
utils["bottom", "not.drive"]  = 3

###############
# Runner
###############

max_iters = 25
v = matrix(0, nrow=length(states), ncol=max_iters)
a = matrix(NA, nrow=length(states), ncol=max_iters)
rownames(v) = rownames(a) = states
options = list("drive" = 0, "not.drive" = 0)

a[ , 1] = rep(which(actions=="not.drive"), 3)
v[ , 1] = utils[ , 2]

iters = 2
while (iters <= max_iters) {
	for (state in states){
		for(action in actions){
			options[action][[1]] = utils[state, action]
			for(next.state in states){
				cmd = paste(action, '["', state, '", "', next.state, '"]', sep="")
				p = eval(parse(text=cmd))
				options[action][[1]] = options[action][[1]] + 
					delta * p * v[next.state, iters-1]
			}
		}
		o = unlist(options)
		v[state, iters] = max(o)
		a[state, iters] = which(o==max(o))
	}
	iters = iters + 1
}

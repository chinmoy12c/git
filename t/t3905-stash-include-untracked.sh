	echo 1 > file &&
	echo 2 > file &&
	echo 3 > file &&
	echo 1 > file2 &&
	echo 1 > HEAD &&
cat > expect <<EOF
?? actual
?? expect
EOF
test_expect_success 'stash save --include-untracked cleaned the untracked files' '
tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))
cat > expect.diff <<EOF
diff --git a/HEAD b/HEAD
new file mode 100644
index 0000000..$tracked
--- /dev/null
+++ b/HEAD
@@ -0,0 +1 @@
+1
diff --git a/file2 b/file2
new file mode 100644
index 0000000..$tracked
--- /dev/null
+++ b/file2
@@ -0,0 +1 @@
+1
diff --git a/untracked/untracked b/untracked/untracked
new file mode 100644
index 0000000..$untracked
--- /dev/null
+++ b/untracked/untracked
@@ -0,0 +1 @@
+untracked
EOF
cat > expect.lstree <<EOF
HEAD
file2
untracked
EOF
test_expect_success 'stash save --include-untracked stashed the untracked files' '
git clean --force --quiet
cat > expect <<EOF
 M file
?? HEAD
?? actual
?? expect
?? file2
?? untracked/
EOF
	test "1" = "$(cat file2)" &&
	test untracked = "$(cat untracked/untracked)"
git clean --force --quiet -d
	echo 4 > file3 &&
blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin))
cat > expect <<EOF
diff --git a/file3 b/file3
new file mode 100644
index 0000000..$blob
--- /dev/null
+++ b/file3
@@ -0,0 +1 @@
+4
EOF
test_expect_success 'stash save --include-untracked dirty index got stashed' '
git reset > /dev/null

	echo 1 > file5 &&
	git stash save --include-untracked --quiet > .git/stash-output.out 2>&1 &&
	echo 1 > expect &&
rm -f expect

cat > .gitignore <<EOF
.gitignore
ignored
ignored.d/
EOF
test_expect_success 'stash save --include-untracked respects .gitignore' '
	echo ignored > ignored &&
	test -s ignored &&
	test -s ignored.d/untracked &&
	test -s .gitignore
	echo 4 > file4 &&
	test -s ignored &&
	test -s ignored.d/untracked &&
	test -s .gitignore
cat > .gitignore <<EOF
ignored
ignored.d/*
EOF
test_expect_success 'stash previously ignored file' '
	echo "!ignored.d/foo" >> .gitignore &&
# Using the encryption tool (bufcrypt)

`bufcrypt encrypt "mysupersecret"`

`AQICAH******************************************************************************************************************cFrAlYeM`

## Contents

* [Before you use the tool](#before-you-use-the-tool)
* [Installation and usage](#installation-and-usage)
  * [Installation](#installation)
  * [Usage](#usage)
* [Intro and motivation](#intro-and-motivation)
  * [How bufcrypt helps with documentation](#how-bufcrypt-helps-with-documentation)
* [How to use bufcrypt in documentation](#how-bufcrypt-helps-with-documentation)

## Before you use the tool

You'll need an AWS key setup on your machine to use the `bufcrypt` encryption
tool. Additionally the key will need permission to access the KMS key used.
Ping Adnan to help you get setup with this if you need it.

## Installation and usage

### Installation

1. Download the script from this repo and place it in `/usr/local/bin/bufcrypt`. 
  * Use `chmod +x /usr/local/bin/bufcrypt` to make it executable.
  * You may need to use `sudo` for this step depending on your local
    environment.
2. Run `bufcrypt help` to view the command documentation.
3. Run `bufcrypt encrypt "MYSECRET"` to test it out. You should receive the
   garbled text that looks like the stuff shown above.
4. Copy the value that showed up in your terminal and run `bufcrypt decrypt
   "paste-the-value-between-quotes"`.
5. You should get `MYSECRET` as a result.

### Usage

**Encrypting single lines of text**

`bufcrypt encrypt "senstive info goes here"`


**Encrypting multiple lines of text**

```
bufcrypt encrypt "my sensitive info
goes
on multiple lines"
```

You can achieve the above by just typing and hitting enter to get a new line.
The terminal will allow any number of new lines until it receives a closing
quotation mark

**Decrypting**

`bufcrypt decrypt "paste-the-encrypted-text-here"`

**Encrypting a file**

`bufcrypt encryptfile "~/.aws/credentials.backup"`

---

**NOTE:** `bufcrypt help` will always carry the most up to date documentation of the
command. This file is in sync at the time of this writing but might fall behind
at times. Please refer to `bufcrypt help` as the primary documentation source
for usage of the command.


## Intro and Motivation

The encryption tool (henceforth referred to as `bufcrypt`) is a small shell
script that uses AWS KMS for ecnrypting small chunks of text. The limit is
currently capped at 4096 bits and will be increased in the near future. The
script will also change to become a binary will allow even binary files to be
encrypted.

Bufcrypt was create to allow us to encrypt values that you need to share via
slack or other insecure channels **if needed**. This is especially useful if you
need to share sensitive information such as AWS keys or login details to an app
with the whole team. It is more convenient than sharing it via multiple one time
secrets. Instead you can use a single ecnrypted value which can be safely pasted
into channels such as slack or email.

### How `bufcrypt` helps with documentation

For the purpose of documentation, bufcrypt is used to encrypt sensitive
information that goes into our documenation.

Sensitive information here is any info that we would avoid sharing in public.
This includes IP addresses, certain commands, SQL structures such as column
names of tables, and internal application subdomain information.

**This should not be used as way to share volatile information such as API
secret tokens inside our documentation. That information MUST remain outside of
the docs regardless of it being encrypted or not.**

A good measuring stick would be, "can an attacker immediately or effortlessly do
something malicious with this information?". If the answer is Yes, it is
volatile. If no, it's probably information that can be encrypted and placed in
the docs.


## How to use `bufcrypt` in documentation

Once you have your encrypted value, to add it to the documentation, please enter
the value between `<secret></secret>` tags. 

If my encrpted value is `908454j3h319u0ashujhufhafa=/134o2urf1+` for example,
I'd use

`<secret>908454j3h319u0ashujhufhafa=/134o2urf1+</secret>` inside the docs when
editing it. The final displayed markdown renders the value as normal (without
the <secret> tag being visible)

The reason for using `<secret>` is that in the future, we'll have a tool to
automatically read the documentation and re-encrypt values with rotated keys.
Having it between `<secret>` tags will make it easier to detect secrets and
rotate them.

There will be additional safeguards for this so don't worry if you forgot to use
the `<secret>` tag. We'll be trying to have as many safeguards as possible for
this.

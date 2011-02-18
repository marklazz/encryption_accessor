# encoding: UTF-8
require 'openssl'
require 'digest/sha1'

module EncryptionAccessor

  module AESCrypt
    extend self

    ALGORITHM = "AES-256-CBC"
    SECRET = "add-your-way-eliasonmedia-02-10-2011"
    ENCODE_DIRECTIVE = 'H*'

    # ALGORITHM = "AES-256-ECB"
    # Decrypts a block of data (encrypted_data) given an encryption key
    # and an initialization vector (iv).  Keys, iv's, and the data 
    # returned are all binary strings.  Cipher_type should be
    # "AES-256-CBC", "AES-256-ECB", or any of the cipher types
    # supported by OpenSSL.  Pass nil for the iv if the encryption type
    # doesn't use iv's (like ECB).
    #:return: => String
    #:arg: encrypted_data => String 
    #:arg: key => String
    #:arg: iv => String
    #:arg: cipher_type => String
    def decrypt(encrypted_data, key = SECRET, iv = nil, cipher_type = ALGORITHM)
        aes = OpenSSL::Cipher::Cipher.new(cipher_type)
        aes.decrypt
        aes.key = key
        aes.iv = iv if iv != nil
        aes.update([encrypted_data].pack(ENCODE_DIRECTIVE)) + aes.final
    end

    # Encrypts a block of data given an encryption key and an 
    # initialization vector (iv).  Keys, iv's, and the data returned 
    # are all binary strings.  Cipher_type should be "AES-256-CBC",
    # "AES-256-ECB", or any of the cipher types supported by OpenSSL.  
    # Pass nil for the iv if the encryption type doesn't use iv's (like
    # ECB).
    #:return: => String
    #:arg: data => String 
    #:arg: key => String
    #:arg: iv => String
    #:arg: cipher_type => String
    def encrypt(data, key = SECRET, iv = nil, cipher_type = ALGORITHM)
        aes = OpenSSL::Cipher::Cipher.new(cipher_type)
        aes.encrypt
        aes.key = key
        aes.iv = iv if iv != nil
        (aes.update(data) + aes.final).unpack(ENCODE_DIRECTIVE)[0]
    end
  end
end

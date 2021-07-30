import gleam/bit_string
import gleam/should

pub fn byte_size_test() {
  bit_string.byte_size(bit_string.from_string("hello"))
  |> should.equal(5)

  bit_string.byte_size(bit_string.from_string(""))
  |> should.equal(0)
}

pub fn append_test() {
  bit_string.from_string("Test")
  |> bit_string.append(bit_string.from_string(" Me"))
  |> should.equal(bit_string.from_string("Test Me"))

  <<1, 2>>
  |> bit_string.append(<<>>)
  |> should.equal(<<1, 2>>)

  <<1, 2>>
  |> bit_string.append(<<3, 4>>)
  |> should.equal(<<1, 2, 3, 4>>)
}

if erlang {
  pub fn part_test() {
    bit_string.from_string("hello")
    |> bit_string.part(0, 5)
    |> should.equal(Ok(bit_string.from_string("hello")))

    bit_string.from_string("hello")
    |> bit_string.part(0, 0)
    |> should.equal(Ok(bit_string.from_string("")))

    bit_string.from_string("hello")
    |> bit_string.part(2, 2)
    |> should.equal(Ok(bit_string.from_string("ll")))

    bit_string.from_string("hello")
    |> bit_string.part(5, -2)
    |> should.equal(Ok(bit_string.from_string("lo")))

    bit_string.from_string("")
    |> bit_string.part(0, 0)
    |> should.equal(Ok(bit_string.from_string("")))

    bit_string.from_string("hello")
    |> bit_string.part(6, 0)
    |> should.equal(Error(Nil))

    bit_string.from_string("hello")
    |> bit_string.part(-1, 1)
    |> should.equal(Error(Nil))

    bit_string.from_string("hello")
    |> bit_string.part(1, 6)
    |> should.equal(Error(Nil))
  }
}

pub fn to_string_test() {
  <<>>
  |> bit_string.to_string
  |> should.equal(Ok(""))

  <<"":utf8>>
  |> bit_string.to_string
  |> should.equal(Ok(""))

  <<"Hello":utf8>>
  |> bit_string.to_string
  |> should.equal(Ok("Hello"))

  <<"ø":utf8>>
  |> bit_string.to_string
  |> should.equal(Ok("ø"))

  <<65535>>
  |> bit_string.to_string
  |> should.equal(Error(Nil))
}

pub fn is_utf8_test() {
  <<>>
  |> bit_string.is_utf8
  |> should.be_true

  <<"":utf8>>
  |> bit_string.is_utf8
  |> should.be_true

  <<"Hello":utf8>>
  |> bit_string.is_utf8
  |> should.be_true

  <<"ø":utf8>>
  |> bit_string.is_utf8
  |> should.be_true

  <<65535>>
  |> bit_string.is_utf8
  |> should.be_false
}

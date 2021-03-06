# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils multilib autotools

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="https://wiki.gentoo.org/wiki/Ufed"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	https://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="sys-libs/ncurses:0="
RDEPEND="${COMMON_DEPEND}
	dev-lang/perl"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

# Populate the patches array for patches applied for -rX releases
# It is an array of patch file names of the form:
# "${FILESDIR}"/${P}-make.globals-path.patch
PATCHES=()

src_prepare() {
	# epatch "${PATCHES[@]}"
	# Change the version number to reflect the ebuild version
	sed -i "s:,\[git\],:,\[${PVR}\],:" configure.ac
	eautoreconf
}

src_configure() {
	econf --libexecdir="${EPREFIX}"/usr/$(get_libdir)/ufed
}

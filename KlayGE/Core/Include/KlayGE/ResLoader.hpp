// ResLoader.hpp
// KlayGE 资源载入器 头文件
// Ver 2.2.0
// 版权所有(C) 龚敏敏, 2004
// Homepage: http://klayge.sourceforge.net
//
// 2.2.0
// 初次建立 (2004.10.26)
//
// 修改记录
///////////////////////////////////////////////////////////////////////////////

#ifndef _RESLOADER_HPP
#define _RESLOADER_HPP

#include <KlayGE/PreDeclare.hpp>
#include <vector>
#include <string>

namespace KlayGE
{
	class ResLoader
	{
	public:
		static ResLoader& Instance();

		void AddPath(std::string const & path);

		ResIdentifierPtr Load(std::string const & name);
		std::string Locate(std::string const & name);

	private:
		ResLoader();

		std::vector<std::string> pathes_;
	};
}

#endif			// _RESLOADER_HPP
